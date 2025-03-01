{
  description = "A flake to package the Genshin Impact theme for SDDM.";
  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs";
    };
  };
  outputs = { self, nixpkgs, ... } @ inputs:
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in
  {
    packages.${system} = {
      genshin-login-theme = import ./genshin-login-theme;
      default = self.outputs.packages.${system}.genshin-login-theme;
    };
  };
}
