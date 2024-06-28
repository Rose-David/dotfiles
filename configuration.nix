# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Enable flakes:
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Enable dynamic linking:
  programs.nix-ld.enable = true;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  hardware.bluetooth.enable = true;
  networking.hostName = "nixos-desktop"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  # services.xserver.displayManager.sddm.enable = true;
  # services.xserver.desktopManager.plasma5.enable = true;
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Configure keymap in X11
  services.xserver.xkb.layout = "us";
  services.xserver.xkb.variant = "";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.davidr = {
    isNormalUser = true;
    description = "David Rose";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      kate
    #  thunderbird
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # terminal:
    wget curl hyfetch fastfetch btop blahaj lsd sl tldr

    # productivity:
    obsidian blanket anki-bin prusa-slicer vscode texliveMedium taskwarrior3
    
    # customization:
    fira-code-nerdfont kde-gruvbox protonvpn-gui

    # music:
    ardour vital tunefish surge-XT sunvox milkytracker odin2 ninjas2 helm lmms
    spotify spicetify-cli
    # moar plugin packs:
    # distrho lsp-plugins

    # gaming:
    space-cadet-pinball heroic prismlauncher mangohud protonup-qt sidequest retroarchFull vesktop

    # gamedev:
    godot_4 aseprite 
    # trenchbroom

    # programming:
    cargo rustc gcc gdb

    # drone stuff:
    betaflight-configurator inav-configurator

    # misc creative:
    gimp libreoffice krita inkscape obs-studio blender-hip freecad wineWowPackages.staging yad winetricks

    # files:
    pika-backup warp

    # KDE Packages:
    kdePackages.partitionmanager kdePackages.kalk kdePackages.kwidgetsaddons libsForQt5.kwidgetsaddons

    # libraries:
    spacenavd

    # pain:
    chromium
  ];

  # Install firefox.
  programs.firefox.enable = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
  };
  programs.gamescope.enable = true;
  programs.gamemode.enable = true;
  programs.alvr = {
    enable = true;
    openFirewall = true;
  };

  programs.fish = {
    enable = true;
    useBabelfish = true;
    shellAliases = { ls = "lsd -a"; hyfetch = "hyfetch -b fastfetch"; };
  };
  users.users.davidr.shell = pkgs.fish;
  programs.starship = {
    enable = true;
    presets = [ "gruvbox-rainbow" ];
  };
  programs.thefuck.enable = true;

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
    viAlias = true;
  };

  programs.kdeconnect.enable = true;

  programs.git = {
    enable = true;
    config = {
      init = {
        defaultBranch = "main";
      };
    };
  };

  programs.adb.enable = true;

  programs.appimage.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
