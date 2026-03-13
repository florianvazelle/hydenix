{
  imports = [
    ./configuration.nix
    ./hardware-configuration.nix

    {
      virtualisation.vmVariant = {
        virtualisation.memorySize = 16192;
        virtualisation.cores = 8;

        # Enable spice agent for clipboard and resolution
        services.spice-vdagentd.enable = true;

        virtualisation.qemu.guestAgent.enable = true;
        virtualisation.qemu.options = [
          # "-vga virtio" # Use virtio
          # "-device VGA,vgamem_mb=256" # More video memory
          "-device virtio-vga-gl,xres=1920,yres=1080"
          "-display gtk,gl=on,grab-on-hover=on" # "Grab on hover" option enable by default
          "-usb -device usb-tablet"
          "-cpu host"
          "-enable-kvm"
          "-machine q35,accel=kvm"
        ];

        services.xserver.videoDrivers = ["virtio"];
      };
    }
  ];
}
