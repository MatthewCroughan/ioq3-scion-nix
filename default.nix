{ ioq3-scion, symlinkJoin, fetchFromGitHub, runCommand }:
let
  fetchedAssets = fetchFromGitHub {
    owner = "nrempel";
    repo = "q3-server";
    rev = "ce4b9511d4bcf1333aa3ed0ebb5d791309859ca4";
    hash = "sha256-veM5a9V6leO5NxvZDfTl3OW3h7bl2u3vZw1za3/iOGA=";
  };
  assets = runCommand "ioq3-assets" {} ''
    mkdir -p $out/share/ioquake3
    cp -r ${fetchedAssets}/baseq3 $out/share/ioquake3
  '';
in ioq3-scion.overrideAttrs {
  name = "ioq3-scion-with-assets";
  postFixup = ''
    cp -r ${fetchedAssets}/baseq3 $out/share/ioquake3
  '';
    #  paths = [
    #    assets
    #    ioq3-scion
    #  ];
}
