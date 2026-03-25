{ pkgs, lib, ... }:
let
  monitors = import ./monitors.nix;
  monitorConfig = lib.concatMapStringsSep "\n" (m: "monitor = ${m}") monitors;

  hyprlandConfig = pkgs.writeText "greetd-hyprland.conf" ''
    ${monitorConfig}

    exec-once = ${lib.getExe pkgs.regreet}; hyprctl dispatch exit
  '';
in
{
  services.greetd.settings.default_session.command =
    lib.mkForce "${lib.getExe pkgs.hyprland} --config ${hyprlandConfig}";
}
