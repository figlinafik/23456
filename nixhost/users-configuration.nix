{
    users={
        users={
            denis={
                isNormalUser=true;
                name="denis";
                createHome = true;
                uid=1000;
                home="/local/den";
                shell = "/bin/fish";
                description = "Denis Samsonov";
                group = "users";
                extraGroups = [ "tty" "wheel" "systemd-network" "video" "audio" "cdrom" "users" "sway" "adbusers" "lp" ];
                openssh.authorizedKeys.keys = [ "ssh-dss AAAAB3Nza... denis@nixhost" ];
            };
        };
    };
}