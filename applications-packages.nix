{ config, pkgs, ... }:

{
  environment.systemPackages =
    with pkgs; [
    chromium
    firefox
    evince
    ];

  nixpkgs.config = {
    chromium = {
      enablePepperFlash = true;
      enablePepperPDF = true;
    };
  };
}

