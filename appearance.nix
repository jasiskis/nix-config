{ config, pkgs, ... }:

{
  fonts = {
    enableFontDir = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
      fira-code
      corefonts
      inconsolata
      ubuntu_font_family
    ];
  };
}
