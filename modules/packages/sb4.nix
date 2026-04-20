{
  perSystem =
    { pkgs, ... }:
    {
      packages.sb4 = pkgs.stdenvNoCC.mkDerivation {
        pname = "stoneblock-4";
        version = "1.11.0";
        meta.mainProgram = "stoneblock-4";

        src = pkgs.fetchurl {
          url = "https://api.feed-the-beast.com/v1/modpacks/public/modpack/130/100272/server/linux";
          sha256 = "9q2PNjEC7Oga/9Qx0PZnazNkMAq78oqBTIhkjDJ9ssQ=";
        };
        dontUnpack = true;

        jre_headless = pkgs.javaPackages.compiler.temurin-bin.jdk-25;

        nativeBuildInputs = with pkgs; [
          makeWrapper
          # groovy
        ];

        preStart = pkgs.writeShellScript "sb4-prestart" ''
          out=$1
          if ! [[ -e "eula.txt" ]]; then
            echo "NOTICE: by running this software, you agree to https://account.mojang.com/documents/minecraft_eula"
            echo "eula=true" > eula.txt
          fi
        '';

        installPhase = ''
          mkdir $out
          cp $src ./installer
          chmod +x ./installer
          #cd $out
          ./installer -pack 130 -version 100272 -auto -force -just-files -dir $out
        '';
        # specify the content hash of this derivations output
        outputHashAlgo = "sha256";
        outputHashMode = "recursive";
        outputHash = "sha256-pIlsyKML+sdmFjH3/XFsr+jhCMwfWvU6dqO6piYwqnw=";
      };
    };
}
