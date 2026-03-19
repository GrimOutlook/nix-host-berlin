{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}:

{
  wayland.windowManager.hyprland.settings.monitor =

    # Monitor connected to Display Port 3
    ''
      # Monitor connected to Display Port 3
        DP-3
              # Manually set to the highest resolution and framrate
              2560x1440@239.99"
              # Leaving at the origin as it's the "Main" display
              0x0
              # Scale of 1 (meaning unscaled)
              1


      # Monitor connected to Display Port 2
        DP-2
              # Manually set to the highest resolution and framrate
              2560x1440@239.99
              # Bottom of the right, vertical, monitor is level with the bottom of the main display
              -2560x1120
              # Scale of 1 (meaning unscaled)
              1
              # Enable transformations e.g. rotation
              transform
              # Rotate 90 degrees
              1


      # Monitor connected to Display Port 1
      DP-1
      # Manually set to the highest resolution and framrate
      2560x1440@239.99
      # Top display is directly above main display
      0x1440
      # Scale of 1 (meaning unscaled)
      1''

  ;
}
