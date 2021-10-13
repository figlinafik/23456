# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

# Use the systemd-boot EFI boot loader.
boot.loader.systemd-boot.enable = true;
boot.loader.efi.canTouchEfiVariables = false;

networking.hostName = "nixsos"; # Define your hostname.
# networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

# Whether to enable the ACPI daemon.
services.acpid.enable = true;

# Select internationalisation properties.
i18n.defaultLocale = "en_US.UTF-8";
i18n.inputMethod = {
          enabled = "ibus";
          ibus.engines = with pkgs.ibus-engines; [ table uniemoji m17n ];
        };
console = {
     font = "LatGrkCyr-8x16";
     keyMap = "us";
     colors = [ "002b36" "dc322f" "859900" "b58900" "268bd2" "d33682" "2aa198" "eee8d5" "002b36" "cb4b16" "586e75" "657b83" "839496" "6c71c4" "93a1a1" "fdf6e3" ]
     };
# Set your time zone.
time.timeZone = "Europe/Amsterdam";

# List packages installed in system profile. To search by name, run:
# $ nix-env -qaP | grep wget
environment.systemPackages = with pkgs; [  wget tmux fish ranger refind ];
  #The configuration of the Nix Packages collection.
  nixpkgs.config = {
       allowBroken = true;
       allowUnfree = true;
  };
#When enabled, installs vim and configures vim to be the default editor using
programs.vim.defaultEditor = true;

# Whether to enable rootston, the reference compositor for wlroots.
#programs.rootston.enable = true;
# Extra packages to be installed system wide.
#programs.rootston.extraPackages = with pkgs;  [ westonLite xwayland rofi ];

# Some programs need SUID wrappers, can be configured further or are
# started in user sessions.
programs.bash.enableCompletion = true;
programs.mtr.enable = true;
programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

# OpenSSH daemon.
services.openssh.enable = true;
services.openssh.allowSFTP = true;
services.openssh.challengeResponseAuthentication = true;

# Samba, which provides file and print services to 
services.samba = {
    enable = false;
    nsswins = true;
    #securityType = "share";
    syncPasswordsByPam = true;
    securityType = "user";
    extraConfig = ''
      #load printers = yes
      #printing = cups
      #printcap name = cups
      workgroup = WORKGROUP
      server string = smbnix
      netbios name = smbnix
      #security = share
      security = user
      use sendfile = yes
      max protocol = smb3
      hosts allow = 192.168.0/24 nixsos  localhost
      hosts deny = 0.0.0.0/0
      #guest account = nobody
      #map to guest = bad #user
      passwd program = /run/wrappers/bin/passwd %u
      pam password change = true
      invalid users = root
   '';
    shares = {
     public = {
       browseable = "yes";
       comment = "Public samba share NIXsOS";
       "guest ok" = "yes";
       #path = "/mnt/Shares/Public";
       path = "/srv/public";
       "read only" = "false";
       #"create mask" = "0644";
       #"directory mask" = "0755";
       #"force user" = "user";
       #"force group" = "users";
     };
     private = {
       browseable = "yes";
       comment = "Private samba share NIXsOS";
       "guest ok" = "no";
       #path = "/mnt/Shares/Private";
       path = "/srv/private";
       "read only" = "true";
       #"create mask" = "0644";
       #"directory mask" = "0755";
       #"force user" = "user";
       #"force group" = "users";
     };
     #printers = {
     #   comment = "All Printers NIXsOS";
     #   path = "/var/spool/samba";
     #   public = "yes";
     #   browseable = "yes";
        # to allow user 'guest account' to print.
     #   "guest ok" = "yes";
     #   writable = "no";
     #   printable = "yes";
        #"create mode" = 0700;
     # };
   };
   #systemd.tmpfiles.rules = [
     #"d /var/spool/samba 1777 root root -"
   #];
 };

# Whether or not to enable the headless Transmission BitTorrent daemon. Default: false
#services.transmission.enable
# TCP port number to run the RPC/web interface. Default: 9091
#services.transmission.port = [ 9091 ];

# Open ports in the firewall.
networking.firewall.allowedTCPPorts = [ 445 139 ];
networking.firewall.allowedUDPPorts = [ 137 138 ];
# Or disable the firewall altogether.
networking.firewall.enable = true;
networking.firewall.allowPing = true;

# Enable CUPS to print documents.
#services.printing.enable = true;
services.printing.enable = true;

# Whether to run the Postfix mail server.
services.postfix = {
 enable = true;
 extraConfig = ''
 inet_interfaces = $myhostname, localhost
 default_transport = error: outside mail is not deliverable 
 '';	
 destination = [ "$myhostname,localhost." "$mydomain, localhost" ] ;
 domain = "localdomain";
 hostname = "localhost";
#networks = "localhost";	
 networksStyle = "host";
#transport = "error: outside mail is not deliverable";
 };

# Whether to enable dleyna-renderer service, a DBus service for handling DLNA renderers.
#services.dleyna-renderer.enable = true;
#services.dleyna-server.enable = true;

# Whether to enable support for Bluetooth..
hardware.bluetooth.enable = true;
#hardware.bluetooth.extraConfig = '' 
#[General]
#ControllerMode = dual 
#'';

# Whether to configure system to use Android Debug Bridge (adb).
programs.adb.enable = true;

# Whether to enable davfs2.
services.davfs2.enable = true;

# Enable sound.
sound.enable = true;
hardware.pulseaudio.enable = true;
hardware.pulseaudio.package = pkgs.pulseaudioFull;

# Enable the X11 windowing system.
services.xserver.enable = true;
#services.xserver.autorun = false;
#services.xserver.layout = "us";
#services.xserver.xkbOptions = "eurosign:e";
services.xserver.tty = null;
#services.xserver.display = null;
services.xserver.resolutions = [ { x = 800; y = 600; }  ];
#services.xserver.serverLayoutSection = ''
#Screen         "Screen0" 0 0
#'';
services.xserver.monitorSection = ''
# Identifier     "Monitor0"
 VendorName     "Unknown"
# ModelName      "LG Electronics F720B"
# ModelName	"CRT-1" 
# HorizSync       30.0 - 71.0	#LG Electronics F720B
# VertRefresh     50.0 - 160.0	#LG Electronics F720B
HorizSync       28.0 - 33.0	#SyncMaster 3
VertRefresh     43.0 - 72.0	#SyncMaster 3
#DisplaySize     286    179
# Option		"UseEdid" "False"
# Option         "UseEdidDpi" "False"
# Option		"DPI" "75x75"
# Option         "DPMS"
# Option      "PreferredMode" "800x600_60"
'';
#services.xserver.deviceSection = ''
# Identifier	"Card0"
# Identifier "Device-nvidia[0]"
# Driver         "nvidia"
# Driver "modesetting"
# BusID	        "PCI:5:0:0" 
# VendorName     "NVIDIA Corporation"
# BoardName      "GeForce GT 240"
#'';
services.xserver.screenSection = ''
# Identifier     "Screen0"
# Device     	"Card0"
# Monitor        "Monitor0"
# DefaultDepth    24
# DefaultDepth    30
# Option         "Stereo" "0"
#Option         "nvidiaXineramaInfoOrder" "CRT-1"
# Option         "metamodes" "GPU-62e0b5b6-a0c0-8916-50ee-b1e1bee762d1.VGA-0: 800x600_60 +0+0 {viewportin=1920x1440}"
# Option         "metamodes" "GPU-62e0b5b6-a0c0-8916-50ee-b1e1bee762d1.VGA-0: 800x600_60 +0+0 {viewportin=1024x768}"
 Option         "metamodes" "800x600_60 +0+0 {viewportin=1024x768}"
# Option         "metamodes" "nvidia-auto-select 864x486 +0+0 {viewportout=896x540+0+0}; 864x486 +0+0 {viewportin=1280x1024}"
# Option         "MultiGPU" "Off"
# Option         "SLI" "off"
# Option         "BaseMosaic" "on"
# SubSection     "Display"
#        Depth       24
#	Depth       30
#	virtual     1280 1024
#        Modes       "800x600_60"
# EndSubSection
'' ;

#services.xserver.videoDrivers = [ "intel" "vesa" ]; 

# Enable touchpad support.
services.xserver.libinput.enable = true;

#NixOS’s default display manager (the program that provides a graphical login prompt and manages the X server) is SLiM.
#services.xserver.displayManager.lightdm.enable = true;
#services.xserver.displayManager.lightdm.greeter.enable = true;
services.xserver.displayManager.sddm.enable = true;

# Enable the KDE Desktop Environment.
#services.xserver.displayManager.sddm.enable = true;
services.xserver.desktopManager.plasma5.enable = true;

# Whether to enable the tiling Wayland compositor Sway. 
#programs.sway.enable = true;
#programs.sway.extraPackages = with pkgs; [ i3status xwayland rxvt_unicode dmenu ];
#programs.sway.extraSessionCommands = 
#"
# Define a keymap (US QWERTY is the default)
#export XKB_DEFAULT_LAYOUT=us
#export XKB_DEFAULT_VARIANT=nodeadkeys
#export XKB_DEFAULT_OPTIONS=grp:alt_shift_toggle,caps:escape
# Change the Keyboard repeat delay and rate
#export WLC_REPEAT_DELAY=660
#export WLC_REPEAT_RATE=25
# The DRM device used when running under the DRM backend.  (Default: card0)
#export WLC_DRM_DEVICE=card1
#";

# Whether to enable way-cooler.
#programs.way-cooler.enable = true;
#programs.way-cooler.extraPackages = with pkgs; [  westonLite xwayland dmenu ]

#Enable vertical synchronization using the specified method.
#services.compton.vSync = true;
# Use kmscon as the virtual console instead of gettys. 
#services.kmscon.enable = false;
#services.kmscon.extraConfig = "font-size=11";
#services.kmscon.extraOptions = "--term xterm-256color";
#services.kmscon.hwRender = true;
# NVIDIA provides a proprietary driver for its graphics cards that has better 3D  
#services.xserver.videoDrivers = [ "nvidiaLegacy340" ];
services.xserver.videoDrivers = [ "modesetting" "intel" "nvidiaLegacy340" ];
#services.xserver.videoDrivers = [ "modesetting" "intel" "nouveau" ];
#services.xserver.videoDrivers = [ "nvidia" ];
#services.xserver.videoDrivers = [ "intel" "nvidiaLegacy340" ];

#hardware.nvidiaOptimus.disable = true;
hardware.nvidia.optimus_prime.enable = true;
hardware.nvidia.optimus_prime.intelBusId = "PCI:0:2:0";
hardware.nvidia.optimus_prime.nvidiaBusId = "PCI:5:0:0";
#hardware.bumblebee = {
#	enable = true;
#	driver = "nvidia";
#	driver = "nouveau";
#	connectDisplay = true;
#	group =  "video";
#	pmMethod = "none";
#	pmMethod = "bbswitch";
#	pmMethod = "switcheroo";
#};


# Whether to enable OpenGL drivers.
#  https://nixos.org/nixos/manual/options.html#opt-hardware.opengl.enable
hardware.opengl.enable = true;
#hardware.opengl.enable = true;
hardware.opengl.driSupport = true;
hardware.opengl.driSupport32Bit = true;
#hardware.opengl.extraPackages = [ pkgs.linuxPackages.nvidia_x11.out ];
#hardware.opengl.extraPackages32 = [ pkgs_i686.linuxPackages.nvidia_x11.out ];
hardware.opengl.s3tcSupport = true;
#hardware.opengl.videoDrivers = true;
   

  # Define a user account. Don't forget to set a password with ‘passwd’.
   users.extraUsers.denis = {
     #isNormalUser = true;
     #uid = 1000;
	#users.users.denis = {
	isNormalUser = true;
	uid = 1000;
	home = "/home/denis";
	description = "Denis Samsonov";
	extraGroups = [ "tty" "wheel" "systemd-network" "video" "audio" "cdrom" "users" "sway" "adbusers" "lp" ];
	openssh.authorizedKeys.keys = [ "ssh-dss AAAAB3Nza... denis@nixsos" ];
	};

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "19.09";	 # Did you read the comment?

}
