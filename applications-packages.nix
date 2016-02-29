{ config, pkgs, ... }:

{
  environment.systemPackages =
    with pkgs; [
    chromium
    firefox
    evince
    vlc
    ];

  nixpkgs.config = {
    chromium = {
      enablePepperFlash = true;
      enablePepperPDF = true;
    };
  };
}

