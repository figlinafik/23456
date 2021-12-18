# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ehci_pci" "ahci" "usb_storage" "sd_mod" "sr_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];
  boot={
    initrd={
      supportedFilesystems=[ "btrfs" ];
    };
    kernelParams = [ "video=VGA-1:800x600@60 video=VGA-2:800x600@60" ];
    resumeDevice="/.swapfile.swap";
  };
  powerManagement={
    enable=true;
    cpuFreqGovernor="ondemand";  #Often used values: "ondemand", "powersave", "performance"
    scsiLinkPolicy="min_power";   #Type: null or one of "min_power", "max_performance", "medium_power", "med_power_with_dipm"
  };
  zramSwap={
    enable=true;
    algorithm="lzo";
    memoryMax=512;
    memoryPercent=60;
    swapDevices=1;
    numDevices=1;
    priority=7;
  };

  fileSystems."/var" =
  { device = "/dev/disk/by-uuid/fe45c0ad-bf5b-4af7-8909-1fb7875ccf24";
    fsType = "btrfs";
    options = [ "subvol=@var" ];
  };

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/2c96685d-8a04-4f82-bd3b-17b125a722e7";
      fsType = "ext4";
    };

  fileSystems."/local" =
    { device = "/dev/disk/by-uuid/fe45c0ad-bf5b-4af7-8909-1fb7875ccf24";
      fsType = "btrfs";
      options = [ "subvol=@home" ];
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/0F5C-0954";
      fsType = "vfat";
    };

  swapDevices =
    [ { device = "/.swapfile.swap"; size=8245; }
    ];

}
