{ config, pkgs, ... }:

{
  networking.hostName = "andremidea"; # Define your hostname.
  networking.extraHosts ="127.0.0.1 andremidea";

  # Set your time zone.
  time.timeZone = "America/Sao_Paulo";

  ## Users
  # users.mutableUsers = true;
  users.extraUsers.guest = {
    isNormalUser = true;
    name = "andremidea";
    group = "users";
    uid = 1000;
    extraGroups = ["wheel" "networkmanager" "docker"];
    createHome = true;
    home = "/home/andremidea";
  };
 
 services.xserver.layout = "us";
 services.xserver.xkbVariant = "colemak";
 
 i18n = {
   consoleKeyMap = /home/andremidea/colemak-1.0/linux_console/colemak.iso15.kmap;
   defaultLocale = "en_US.UTF-8";
 };
}
