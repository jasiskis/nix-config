{ stdenv, fetchurl, config, pkgs, ... }:

  stdenv.mkDerivation {
	name = "slack-2.0.0";
	
 	src = fetchurl {
		url = "https://slack-ssb-updates.global.ssl.fastly.net/linux_releases/slack-desktop-2.0.0-amd64.deb";
		sha256 = "0ssi1wpaf7plaswqqjwigppsg5fyh99vdlb9kzl7c9lng89ndq1i";
	};
	doCheck = false;
  }

  {


  environment.systemPackages =
    with pkgs; [
    htop
    tree
    ack
    file
    feh
    scrot
    xclip
    gawk
    jq
    unzip
    sl
    xlsfonts
    ctags
    xorg.xbacklight
    xscreensaver

    # networking
    mtr
    ldns
    ];


  systemd.user.services.xscreensaver = {
	  description = "Xscreen saver";

	  serviceConfig = {
		  Type = "simple";
		  ExecStart = "${pkgs.xscreensaver}/bin/xscreensaver";
		  ExecStop = "${pkgs.xscreensaver}/bin/xscreensaver-command -deactivate";
		  Restart = "always";
	  };
	  wantedBy = [ "default.target" ];
  };

 systemd.services.xscreensaver.enable = true;
}

