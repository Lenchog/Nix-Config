{
  perSystem =
    { pkgs, ... }:
    let
      version = "100298";
    in
    {
      packages = {
        stoneblock-4 = pkgs.stdenvNoCC.mkDerivation {
          pname = "sb4-installer";
          version = "1.12.0";
          src = pkgs.fetchurl {
            url = "https://api.feed-the-beast.com/v1/modpacks/public/modpack/130/${version}/server/linux";
            sha256 = "NobyDRE3zmbYDhBRqZpL7NFJ4VQRjC/Y8OImWYF6bvc=";
          };
          dontUnpack = true;
          installPhase = ''
            mkdir $out
            mkdir $out/lib
            cp $src ./installer
            chmod +x ./installer
            ./installer -pack 130 -version ${version} -auto -force -just-files -dir $out/lib
          '';
          # specify the content hash of this derivations output
          outputHashAlgo = "sha256";
          outputHashMode = "recursive";
          outputHash = "qi9g+Fdw5jG7Znnq7ReILOALAfnyirvwl7FA/WPrrU4=";
        };
      };
    };
}
