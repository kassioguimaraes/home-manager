{
  description = "Home Manager configuration of kassio";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixgl = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/nixGL";
    };
  };

  outputs = { nixpkgs, nixgl, home-manager, ... }:
    let
      system = "x86_64-linux";
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ nixgl.overlay ];
        };
    in {
      homeConfigurations."kassio" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [ ./home.nix ];

        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix

        extraSpecialArgs = { inherit nixgl; };
      };
    };
}
