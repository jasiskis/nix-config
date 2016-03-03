let nixpkgs = import <nixpkgs> {};
    stdenv = nixpkgs.stdenv;
    fetchurl = nixpkgs.fetchurl;
    rpmextract = nixpkgs.rpmextract;
    makeWrapper = nixpkgs.makeWrapper;
    buildEnv = nixpkgs.buildEnv;
    gvfs = nixpkgs.gvfs;

 slackEnv = buildEnv {
    name = "env-slack";
    paths = with nixpkgs; [
      stdenv.cc.cc zlib glib dbus gtk atk pango freetype libgnome_keyring3
      fontconfig gdk_pixbuf cairo cups expat libgpgerror alsaLib nspr nss
      xorg.libXrender xorg.libX11 xorg.libXext xorg.libXdamage xorg.libXtst
      xorg.libXcomposite xorg.libXi xorg.libXfixes xorg.libXrandr
      xorg.libXcursor libcap systemd libnotify gnome.GConf
    ];
  };
	
in stdenv.mkDerivation {
  name = "slack-2.0.0";
  src = fetchurl  {
		url = "https://slack-ssb-updates.global.ssl.fastly.net/linux_releases/slack-2.0.0-0.1.fc21.x86_64.rpm";
		sha256 = "cf3f32b8de93c01224e335a087eec2df6fea9aab586ae77dc9cb4d03231d1035";
  };

  buildInputs = [ rpmextract makeWrapper ];

  phases = [ "unpackPhase" "installPhase" "fixupPhase" "distPhase" ];

  unpackPhase = ''
    rpmextract $src
  '';

  installPhase = ''
    install -d $out/usr/share
    mkdir -p $out/bin
    cp -dr --no-preserve='ownership' usr/share/slack $out/usr/share/slack
    ln -s $out/usr/share/slack/slack $out/bin/slack
    patchelf --set-interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" \
      $out/usr/share/slack/slack
    wrapProgram $out/usr/share/slack/slack
    wrapProgram $out/bin/slack \
      --prefix "LD_LIBRARY_PATH" : "${slackEnv}/lib:${slackEnv}/lib64" \
      --prefix "PATH" : "${gvfs}/bin"
  '';

  meta = with stdenv.lib; {
    homepage = http://slack.com;
    platforms = platforms.linux;
    description = "Slack Chat";
  };
}
