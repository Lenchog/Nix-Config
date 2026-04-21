{ self, lib, ... }:
{
  perSystem =
    { pkgs, ... }:
    {
      packages = {
        stoneblock-4 = pkgs.stdenvNoCC.mkDerivation {
          pname = "sb4-installer";
          version = "1.11.0";
          src = pkgs.fetchurl {
            url = "https://api.feed-the-beast.com/v1/modpacks/public/modpack/130/100272/server/linux";
            sha256 = "9q2PNjEC7Oga/9Qx0PZnazNkMAq78oqBTIhkjDJ9ssQ=";
          };
          dontUnpack = true;
          installPhase = ''
            mkdir $out
            mkdir $out/lib
            cp $src ./installer
            chmod +x ./installer
            ./installer -pack 130 -version 100272 -auto -force -just-files -dir $out/lib
          '';
          # specify the content hash of this derivations output
          outputHashAlgo = "sha256";
          outputHashMode = "recursive";
          outputHash = "UWaTZHCkMsRaYSYEi9gLXa8i3DFNisBv32592e5Q9/M=";
        };
      };
    };
}
