# https://github.com/thimslugga/evga-xr1-udev-rules/blob/91726bf919ff9bb983848dbc875b56b3dd02d4bb/rules/85-evga-xr1-capdev.rules

{
  services.udev.extraRules = ''
    # EVGA XR1 Lite capture card device
    KERNEL=="video[0-9]*", SUBSYSTEM=="video4linux", SUBSYSTEMS=="usb", ATTRS{idVendor}=="3842", ATTRS{idProduct}=="310a", SYMLINK+="evga-xr1-lite"

    # EVGA XR1 capture card device
    #KERNEL=="video[0-9]*", SUBSYSTEM=="video4linux", SUBSYSTEMS=="usb", ATTRS{idVendor}=="3842", ATTRS{idProduct}=="310a", SYMLINK+="evga-xr1"

    # EVGA XR1 Pro capture card device
    KERNEL=="video[0-9]*", SUBSYSTEM=="video4linux", SUBSYSTEMS=="usb", ATTRS{idVendor}=="3842", ATTRS{idProduct}=="310b", SYMLINK+="evga-xr1-pro"
  '';
}
