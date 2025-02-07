{ config, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      #./vm.nix
      inputs.home-manager.nixosModules.default
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.timeout = 0;
  boot.kernelParams = [
    "nvme_core.default_ps_max_latency_us=200"  
  ];


  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Bangkok";

  services.devmon.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;
  
  services.mullvad-vpn.enable = true;
  services.mullvad-vpn.package = pkgs.mullvad-vpn;

  # Enable the X11 windowing system.
  services.xserver.enable = true;
 
  services.xserver.displayManager.gdm.enable = true;

  # Configure keymap in X11
  services.xserver = {
    xkb.layout = "us";
    xkb.variant = "";
    videoDrivers = ["nvidia"];
  };

  hardware.nvidia.open = false;
  hardware.nvidia.modesetting.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;
  
  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.rot10rin5 = {
    isNormalUser = true;
    description = "rot10rin5";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    ];
  };

  home-manager = {
    # also pass inputs to home-manager modules
    extraSpecialArgs = {inherit inputs;};
    users = {
      "rot10rin5" = import ./home.nix;
    };
};

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
     foremost
     bottles
     discord
     dolphin
     gccgo14
     gimp
     git
     godot_4
     gparted
     grim
     heroic
     htop
     jdk17
     jdk21
     kitty
     krita
     libsForQt5.kdenlive
     libreoffice
     librewolf
     neofetch
     neovim
     networkmanagerapplet
     manim
     mullvad-vpn
     obsidian
     obs-studio
     openjdk8-bootstrap
     texliveFull
     dunst
     prismlauncher
     protonup
     python3
     vlc
     wget
     wine
     unzip
     remmina
     rofi-wayland
     (waybar.overrideAttrs (oldAttrs: {
       mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
       })
     )
     zip
  ];

  fonts.packages = with pkgs; [
    sarabun-font
  ];

  environment.sessionVariables = {
     EDITOR = "nvim";
     WLR_NO_HARDWARE_CURSORS = "1";
  };

  nixpkgs.config.permittedInsecurePackages = [
     "electron-25.9.0"
  ];

  hardware.graphics = {
     enable = true;
  };

  programs.hyprland = {
     enable = true;
     xwayland.enable = true;
     package = inputs.hyprland.packages."${pkgs.system}".hyprland;
  }; 

  programs.steam = {
     enable = true;
     gamescopeSession.enable = true;
     remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
     dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };

  programs.gamemode.enable = true;

  system.stateVersion = "24.11";
  
  stylix = {
    enable = true;
    image = ./black.png;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/bright.yaml";
    fonts = {
      monospace = {
        package = pkgs.nerdfonts.override {fonts = ["JetBrainsMono"];};
        name = "JetBrainsMono Nerd Font Mono";
      };
      sansSerif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Sans";
      };
      serif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Serif";
      };
    };
  };
}
