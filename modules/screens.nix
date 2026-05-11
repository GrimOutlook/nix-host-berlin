{ pkgs, lib, ... }:
let
  # Shared monitor configuration for berlin
  # Used by both the user Hyprland session and the greetd greeter
  monitors = [
    "DP-3, 2560x1440@239.99, 0x0, 1"
    # Display Port 2, Highest Preset, To the right of the main screen, no scaling, rotated 270 degrees.
    "DP-2, 2560x1440@239.99, 2560x-1120, 1, transform, 3"
    "DP-1, 2560x1440@239.99, 0x-1440, 1"
  ];
  monitorConfig = lib.concatMapStringsSep "\n" (m: "monitor = ${m}") monitors;

  hyprlandConfig = pkgs.writeText "greetd-hyprland.conf" ''
    ${monitorConfig}

    exec-once = ${lib.getExe pkgs.regreet}; hyprctl dispatch exit
  '';
in
{
  host.home-manager.config.wayland.windowManager.hyprland.settings.monitor = monitors;
  services.greetd.settings.default_session.command =
    lib.mkForce "${lib.getExe pkgs.hyprland} --config ${hyprlandConfig}";
}
