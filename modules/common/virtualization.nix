{ pkgs, ... }:

{
  virtualisation = {
    libvirtd = {
      enable = true;

      qemu = {
        swtpm.enable = true;

        ovmf = {
          enable = true;

          packages = with pkgs; [
            OVMFFull.fd
          ];
        };
      };
    };

    spiceUSBRedirection.enable = true;
  };

  services.spice-vdagentd.enable = true;

  environment.systemPackages = with pkgs; [
    spice
    spice-protocol
  ];
}
