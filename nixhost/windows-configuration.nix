{
services={
    xserver={
        monitorSection="
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
        ";
        # deviceSection="
        # Identifier	"Card0"
        # Identifier "Device-nvidia[0]"
        # Driver         "nvidia"
        # Driver "modesetting"
        # BusID	        "PCI:5:0:0" 
        # VendorName     "NVIDIA Corporation"
        # BoardName      "GeForce GT 240"
        # ";
        screenSection="
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
        ";
    };
}