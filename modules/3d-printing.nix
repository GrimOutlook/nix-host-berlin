{ pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      prusa-slicer
      orca-slicer
    ];
  };
}
