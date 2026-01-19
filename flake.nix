{
  description = "Lucas's Nix configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
  };

  # Build darwin flake using:
  # $ sudo darwin-rebuild switch --flake .#mbp
  outputs = inputs: {
    darwinConfigurations.mbp = nix-darwin.lib.darwinSystem {
      modules = [
        inputs.nix-homebrew.darwinModules.nix-homebrew
        ./modules/mbp
      ];
    };
  };
}
