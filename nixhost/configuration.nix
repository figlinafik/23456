# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./windows-configuration.nix
      ./users-configuration.nix
    ];

  # Use the GRUB 2 boot loader.
  # boot.loader.grub.enable = true;
  # boot.loader.grub.version = 2;
  # boot.loader.grub.efiSupport = true;
  # boot.loader.grub.efiInstallAsRemovable = true;
  # boot.loader.efi.efiSysMountPoint = "/boot/efi";
  # Define on which hard drive you want to install Grub.
  # boot.loader.grub.device = "/dev/sda"; # or "nodev" for efi only
  boot={
    loader={
      systemd-boot={
        enable=true;
        consoleMode="auto";
        configurationLimit=10;
        editor=true;
      };
      efi={
        canTouchEfiVariables=false;
        efiSysMountPoint="/boot";
      };
      timeout=7;
    };
  };

  # networking.hostName = "nixhost"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Set your time zone.
  # time.timeZone = "Europe/Amsterdam";
  time={
    timeZone="Europe/Madrid";
    hardwareClockInLocalTime=false;
  };

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  # networking.useDHCP = false;
  # networking.interfaces.enp2s0.useDHCP = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  # };
  i18n={
    defaultLocale="en_US.UTF-8";
    inputMethod={
      enabled="ibus";
      ibus.engines = with pkgs.ibus-engines; [ table uniemoji m17n ];
    };
  };
  console={
    font="LatGrkCyr-8x16";
    keyMap="us";
    colors=[ "002b36" "dc322f" "859900" "b58900" "268bd2" "d33682" "2aa198" "eee8d5" "002b36" "cb4b16" "586e75" "657b83" "839496" "6c71c4" "93a1a1" "fdf6e3" ];
  };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;


  # Enable the GNOME 3 Desktop Environment.
  # services.xserver.displayManager.gdm.enable = true;
  # services.xserver.desktopManager.gnome.enable = true;
  

  # Configure keymap in X11
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # sound.enable = true;
  # hardware.pulseaudio.enable = true;
  sound={
    enable=true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  # users.users.jane = {
  #   isNormalUser = true;
  #   extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
  # };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  # environment.systemPackages = with pkgs; [
  #   vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #   wget
  #   firefox
  # ];
  environment={
    systemPackages = with pkgs; [ wget ranger ];
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
  programs={
    fish={
      enable=true;
      useBabelfish=true;
    };
    tmux={
      enable=true;
      keyMode="vi";
      terminal="screen-256color";
      customPaneNavigationAndResize=true;
    };
    neovim={
      enable=true;
    };
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;
  services={
    acpid={
      enable=true;
    };
    xserver={
      enable = true;
      displayManager={
        sddm={
          enable=true;
          autoNumlock=true;
        };
      };
      desktopManager={
        gnome={
          enable=true;
        };
      };
      videoDrivers = [ "modesetting" "intel" "nvidiaLegacy340" ];
    };
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
  networking={
    hostName="nixhost"; # Define your hostname.
    wireless={
      enable = false;  # Enables wireless support via wpa_supplicant.
    };
    useDHCP = false;
  };

  # Whether to try to load kernel modules for all detected hardware.
  hardware={
    pulseaudio={
      enable=true;
      package=pkgs.pulseaudio;
      support32Bit=true;
    };
    bluetooth={
      enable=true;
    };
    nvidia={
      optimus_prime={
        enable=true;
        intelBusId="PCI:0:2:0";
        nvidiaBusId = "PCI:5:0:0";
      };
    };
    opengl={
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
      s3tcSupport = true;
    };
  };

  # The configuration of the Nix Packages collection. (For details, see the Nixpkgs 
  # documentation.) It allows you to set package configuration options.
  # Ignored when nixpkgs.pkgs is set.
  # Type: nixpkgs config
  # Default: { }
  # Example:
  # { allowBroken = true; allowUnfree = true; }
  nixpkgs={
    config={
      pulseaudio=true;
      allowUnfree = true;
    };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.05"; # Did you read the comment?

}

