{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = [
    "nvme"
    "thunderbolt"
    "xhci_pci"
    "ahci"
    "usbhid"
    "usb_storage"
    "sd_mod"
  ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/044b1b95-6a27-470c-a903-56b93e37426b";
    fsType = "btrfs";
    options = [
      "subvol=root"
      "compress=zstd"
    ];
  };

  fileSystems."/nix" = {
    device = "/dev/disk/by-uuid/044b1b95-6a27-470c-a903-56b93e37426b";
    fsType = "btrfs";
    options = [
      "subvol=nix"
      "compress=zstd"
    ];
  };

  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/044b1b95-6a27-470c-a903-56b93e37426b";
    fsType = "btrfs";
    options = [
      "subvol=home"
      "compress=zstd"
      "noatime"
    ];
  };

  fileSystems."/swap" = {
    device = "/dev/disk/by-uuid/044b1b95-6a27-470c-a903-56b93e37426b";
    fsType = "swap";
    options = [
      "subvol=swap"
      "noatime"
    ];
  };

  swapDevices = [
    {
      device = "/swap/swapfile";
      # Amount of RAM in GB * Number of MB in a GB * Recommended scaling for hibernation
      # Can't use floats so Scaling factor is built into RAM amount and is which is 1.5 * 64
      size = 96 * 1024;
    }
  ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
