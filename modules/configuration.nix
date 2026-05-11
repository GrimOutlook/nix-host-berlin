{ inputs, pkgs, ... }:
{
  host = {
    bluetooth.enable = true;
    build-arm.enable = true;
    dev = {
      enable = true;
      lang = {
        nix.enable = true;
        python.enable = true;
        rust.enable = true;
      };
    };
    hostname = "berlin";
    network-diag.enable = true;
    type.desktop.enable = true;
    virtualization.enable = true;
  };

  environment.systemPackages = with pkgs; [
    chromium
    obsidian
    efibootmgr
  ];

  host.home-manager.config = {
    imports = [
      inputs.homelab.homeManagerModules.default
    ];

    homelab.ssh_config.enable = true;
  };
}
