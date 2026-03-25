{
  description = "NixOS configuration for berlin";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";

    nix-config = {
      url = "github:GrimOutlook/nix-config";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{ self, nix-config, ... }:
    let
      pkgs = import inputs.nixpkgs {
        system = "x86_64-linux";
        config.allowUnfree = true;
      };
    in
    nix-config.inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        nix-config.modules.flake.hosts
        nix-config.modules.flake.host-info
        (nix-config + "/flakes/systems.nix")
      ];

      modules = [
        "bluetooth"
        "desktop"
        "dev"
        "networking"
        "virtualization"
        "lang_rust"
        "lang_toml"
      ];

      host-info = rec {
        name = "berlin";
        flake = "github:GrimOutlook/nix-host-${name}";
      };

      nixos = {
        modules = [
          ./modules/hardware.nix
          ./modules/gaming.nix
          ./modules/qmk.nix
          ./modules/gpu-screen-recorder.nix
        ];
        environment.systemPackages = with pkgs; [
          chromium
        ];
        system = {
          autoUpgrade.enable = true;
          stateVersion = "25.05";
        };
      };

      home = {
        imports = [
          ./modules/displays.nix
          ./modules/3d-printing.nix
        ];
        home = {
          stateVersion = "25.11";
        };
      };
    };
}
