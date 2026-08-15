{
  perSystem =
    { pkgs, ... }:
    let
      version = "100442";
      id = "125";
    in
    {
      packages = {
        evo = pkgs.stdenvNoCC.mkDerivation {
          pname = "evo-installer";
          version = "${version}";
          src = pkgs.fetchurl {
            url = "https://api.feed-the-beast.com/v1/modpacks/public/modpack/${id}/${version}/server/linux";
            sha256 = "mr/8jhTFWPUgET9qOP2qSGT1dC2/t+cHXYNA+pUZgzI=";
          };
          dontUnpack = true;
          installPhase = ''
            mkdir $out
            mkdir $out/lib
            cp $src ./installer
            chmod +x ./installer
            ./installer -pack ${id} -version ${version} -auto -force -just-files -dir $out/lib
          '';
          # specify the content hash of this derivations output
          outputHashAlgo = "sha256";
          outputHashMode = "recursive";
          outputHash = "4q5Trk10cGrmreguUU61uYDv0nmtVcl+ChAQqHrqPhc=";
        };
      };
    };
}
