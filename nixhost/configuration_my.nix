
{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];
services= {
    gvfs= {
        enable = true;
        package = lib.mkForce pkgs.gnome3.gvfs;
    };
    samba= {
        enable=false;
        nsswins=true;
        # securityType="share";
        syncPasswordsByPam=true;
        securityType="user";
        extraConfig="
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
        ";
    };
};
 system.stateVersion = "21.05"; # Did you read the comment?

}