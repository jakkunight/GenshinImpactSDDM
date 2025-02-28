{
  description = "A flake to package the Genshin Impact theme for SDDM.";
  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs";
    };
    flake-utils = {
      url = "github:numtide/flake-utils";
    };
    genshin-theme = {
      url = "github:nicefaa6waa/genshin-sddm-theme";
      flake = false;
    };
    nightbg = {
      url = "file+https://www.dropbox.com/scl/fi/e6kio0zet8j5lax9ztu7y/nightbg.mp4?rlkey=29ni1jq0a9sr02b6l0s61oiiq&st=en7rqgmy&dl=0";
      flake = false;
    };
    morningbg = {
      url = "file+https://www.dropbox.com/scl/fi/8om5p5d3ul984krbnhfgu/morningbg.mp4?rlkey=jedf5qcycj310oqx8djy9yomz&st=yupg7zz8&dl=0";
      flake = false;
    };
    sunrisebg = {
      url = "file+https://www.dropbox.com/scl/fi/f3x5jfr8sk06ij3c8kgoy/sunrisebg.mp4?rlkey=r0lzylvhze4lq3xglwkvf4iya&st=ybukfsgv&dl=0";
      flake = false;
    };
  };
  outputs = { self, nixpkgs, flake-utils, ... } @ inputs: flake-utils.lib.eachDefaultSystem (system:
  let
    pkgs = nixpkgs.legacyPackages.${system};
  in
  {
    packages.default = pkgs.stdenv.mkDerivation {
      name = "genshin-sddm-theme";
      src = inputs.genshin-theme;
      dontWrapQtApps = false;
      nativeBuildInputs = with pkgs.libsForQt5.qt5; [
        qtdeclarative
        wrapQtAppsHook
        qtmultimedia
        qtquickcontrols
        qtgraphicaleffects
      ];
      dontBuild = true;
      installPhase = ''
        mkdir -p $out
        cp -r ${inputs.nightbg} ./backgrounds
        cp -r ${inputs.morningbg} ./backgrounds
        cp -r ${inputs.sunrisebg} ./backgrounds
        cp -R ./* $out/
      '';
    };
  });
}
