{ config, pkgs, ... }:

{
  environment.systemPackages =
    with pkgs; [
    termite
    haskellPackages.xmobar
    haskellPackages.yeganesh
    dmenu
    rxvt_unicode
    xlockmore
    stalonetray
    scrot
    ];
}

