{ lib, ... }:
{
  perSystem =
    { pkgs, ... }:
    let
      # Groovy script to parse meta inf from jar
      readMetaInf = /* groovy */ ''
        import java.net.URL
        import java.io.File
        import java.util.jar.Attributes.Name

        jarPath = args[0]
        pathPrefix = args[1]
        jar = new URL("jar:file:" + new File(jarPath).getAbsolutePath()+ "!/")
        attributes =  jar.openConnection().getManifest().getMainAttributes()
        println(attributes.get(Name.MAIN_CLASS))
        println(attributes.get(Name.CLASS_PATH).split(' ').collect{"$pathPrefix/$it"}.join(':'))
      '';
    in
    {
      packages.gtnh = pkgs.stdenvNoCC.mkDerivation rec {
        pname = "gt-new-horizons";
        version = "2.9.0-beta-2";
        meta.mainProgram = "gt-new-horizons";

        src = pkgs.fetchzip {
          url = "https://downloads.gtnewhorizons.com/ServerPacks/GT_New_Horizons_${version}_Server_Java_17-25.zip";
          sha256 = "7AAHYUlELt8kZR8quRxIiR+3osgpBWb0sstO6aDBp6U=";
          stripRoot = false;
        };

        jre_headless = pkgs.javaPackages.compiler.temurin-bin.jdk-26;

        nativeBuildInputs = with pkgs; [
          makeWrapper
          groovy
        ];

        preStart = pkgs.writeShellScript "gtnh-prestart" ''
          out=$1
          for name in "config" "serverutilities" "server.properties"; do
            if ! [[ -e "$name" ]]; then
              echo "$name missing. Copying it from $out/lib."
              cp -rL "$out/lib/$name" .
              chmod +w "$name" -R
            fi
          done
          if ! [[ -e "eula.txt" ]]; then
            echo "NOTICE: by running this software, you agree to https://account.mojang.com/documents/minecraft_eula"
            echo "eula=true" > eula.txt
          fi
        '';

        installPhase = ''
          mkdir $out
          ln -s $src $out/lib
          mainJar="$out/lib/lwjgl3ify-forgePatches.jar"
          # Get main_class and class_path from main jar
          { read main_class; read class_path; } < <(groovy -e ${lib.escapeShellArg readMetaInf} $mainJar $out/lib)
          # Add extra required jars to class_path
          class_path+="$(printf ':%s' $out/lib/mods/lwjgl3ify-*.jar)"
          # Collect mods and pass them as --mods. Has to be in runtime to get their path relative to PWD
          makeWrapper ${lib.getExe jre_headless} $out/bin/gt-new-horizons \
            --run "$preStart $out" \
            --append-flags "@$out/lib/java9args.txt -cp $mainJar:$class_path $main_class nogui"
        '';
      };
    };
}
