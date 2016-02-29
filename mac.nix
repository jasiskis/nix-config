## mac hardware / low-level stuff

{ config, pkgs, ... }:


{

  nixpkgs.config = {
    packageOverrides = pkgs : {
      bluez = pkgs.bluez5;
    };
  };

  hardware.enableAllFirmware = true;

  hardware.bluetooth.enable = true;


  
  # select the right sound card,
  boot.extraModprobeConfig = ''
    options snd_hda_intel enable=0,1
  '';

  # Use the gummiboot efi boot loader.
  boot.loader.gummiboot.enable = true;
  boot.loader.gummiboot.timeout = 5;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.cleanTmpDir = true;
  
  # configure multitouch options 
  services.xserver = {
    multitouch.enable = true;
    multitouch.invertScroll = true;
    multitouch.ignorePalm = true;
    multitouch.additionalOptions = ''
	Option          "Sensitivity" "0.95"
        Option          "FingerHigh" "12"
        Option          "FingerLow" "1"
        Option          "IgnoreThumb" "true"
        Option          "IgnorePalm" "true"
        Option          "TapButton1" "0"
        Option          "TapButton2" "0"
        Option          "TapButton3" "0"
        Option          "TapButton4" "0"
        Option          "ClickFinger1" "1"
        Option          "ClickFinger2" "3"
        Option          "ClickFinger3" "3"
        Option          "ButtonMoveEmulate" "false"
        Option          "ButtonIntegrated" "true"
        Option          "ClickTime" "25"
        Option          "BottomEdge" "25"
        Option          "SwipeLeftButton" "8"
        Option          "SwipeRightButton" "9"
        Option          "SwipeUpButton" "0"
        Option          "SwipeDownButton" "0"
        Option          "ScrollDistance" "75"
        Option          "ScrollUpButton" "5"
        Option          "ScrollDownButton" "4"
   '';
   config = ''
	Section "InputClass"
		Identifier "Mouse do André"
	  	MatchIsPointer "yes"
		Option "AccelerationProfile" "-1"
		Option "Device Accel Constant Deceleration" "0.800000"
		Option "Device Accel Velocity Scaling" "5.000000"
		Option "Evdev Scrolling Distance" "-1, -1, -1"
		Option "Evdev Wheel Emulation"	"10"
		Option "Evdev Wheel Emulation Axes" "0, 0, 4, 5"
		Option "Evdev Wheel Emulation Inertia" "1"	
		Option "Evdev Wheel Emulation Timeout" "40"
		Option "Evdev Wheel Emulation Button"	"4"
	EndSection
  '';
  };
}


