# Guide: 
# https://github.com/FrameworkComputer/linux-docs/blob/main/framework12/nixOS.md#manual-nixos-configuration-framework-12-intel-core-series-3
{ config, pkgs, ... }:

{
# Framework 12 (Dahlia) tablet mode + rotation
  boot.initrd.kernelModules = [ "pinctrl_intel_platform" ];

  boot.extraModprobeConfig = ''
    softdep soc_button_array pre: pinctrl_intel_platform
  '';

# Screen auto-rotation (accelerometer)
  hardware.sensor.iio.enable = true;

# On-screen keyboard (KDE Plasma) + sensor CLI tool
  environment.systemPackages = with pkgs; [
    kdePackages.plasma-keyboard
    iio-sensor-proxy
  ];
}
