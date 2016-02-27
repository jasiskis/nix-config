{ config, pkgs, ... }:

{

  environment.systemPackages =
    with pkgs; [
    wget
    git
    dropbox
    vimNox
    gnome3.gnome_terminal
  ];
}
