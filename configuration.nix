# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ lib, config, pkgs, inputs, ... }:

{
  imports = [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Enable flakes:
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  home-manager.backupFileExtension = "backup2";

  # Enable dynamic linking:
  programs.nix-ld.enable = true;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Hardware.
  hardware.bluetooth.enable = true;
  hardware.amdgpu.opencl.enable = true;

  networking.hostName = "nixos-desktop"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;
  services.avahi = {
    enable = true;
    openFirewall = true;
    nssmdns4 = true;
    publish = {
      enable = true;
      domain = true;
      addresses = true;
      workstation = true;
      hinfo = true;
      userServices = true;
    };
  };

  services.openssh = {
    enable = true;
    openFirewall = true;
    settings.DenyUsers = [ "root" ];
  };

  networking.interfaces.enp14s0.wakeOnLan = {
    enable = true;
    policy = [ "magic" ];
  };
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
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    audio.enable = true;
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
    packages = with pkgs;
      [
        kate
        #  thunderbird
      ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  fonts.packages = with pkgs; [ nerd-fonts.fira-code nerd-fonts._3270 ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # terminal:
    wget
    curl
    gh
    hyfetch
    fastfetch
    btop-rocm
    blahaj
    lsd
    sl
    bat
    tldr
    openssh
    croc
    zellij
    blisp

    # productivity:
    obsidian
    blanket
    anki-bin
    prusa-slicer
    texliveMedium
    taskwarrior3
    rpi-imager
    nmap
    tigervnc
    zoom-us
    geekbench

    # customization:
    kde-gruvbox
    protonvpn-gui

    # music:
    ardour
    vital
    # tunefish
    surge-XT
    sunvox
    milkytracker
    odin2
    ninjas2
    helm
    # lmms
    spotify
    openutau
    famistudio
    # moar plugin packs:
    # distrho lsp-plugins

    # gaming:
    space-cadet-pinball
    heroic
    prismlauncher
    mangohud
    protonup-qt
    sidequest
    # retroarchFull
    fsuae-launcher
    vice
    osu-lazer-bin
    xivlauncher
    nxengine-evo
    ringracers
    srb2
    gzdoom
    dsda-doom
    doomrunner
    itch
    (discord.override { withVencord = true; })
    (inputs.olympus-nixpkgs.legacyPackages.${pkgs.system}.olympus.override { celesteWrapper = steam-run; })
    (inputs.sgdboop-nixpkgs.legacyPackages.${pkgs.system}.sgdboop)

    # gamedev:
    godot_4
    aseprite
    # trenchbroom

    # programming:
    vscode-fhs
    vscode-extensions.vadimcn.vscode-lldb
    cargo
    rustc
    gcc
    gdb
    clang
    clang-tools
    lldb
    python3
    (alpaca.override { ollama = pkgs.ollama-rocm; })
    ollama-rocm

    # drone stuff:
    betaflight-configurator
    inav-configurator

    # misc creative:
    gimp
    libreoffice
    krita
    inkscape
    obs-studio
    blender-hip
    freecad
    openscad
    vlc

    # files:
    pika-backup
    warp

    # KDE Packages:
    kdePackages.partitionmanager
    kdePackages.kalk
    kdePackages.kwidgetsaddons
    kdePackages.francis
    kdePackages.kmines

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
    shellAliases = {
      ls = "lsd -a";
      hyfetch = "hyfetch -b fastfetch";
    };
  };

  environment.variables = let
    makePluginPath = format:
      (lib.makeSearchPath format [
        "$HOME/.nix-profile/lib"
        "/run/current-system/sw/lib"
        "/etc/profiles/per-user/$USER/lib"
      ]) + ":$HOME/.${format}";
  in {
    # enable ROCm support on 7700XT, even though it's not officially supported
    HSA_OVERRIDE_GFX_VERSION = "11.0.2";

    # fixes audio plugin locations
    DSSI_PATH = makePluginPath "dssi";
    LADSPA_PATH = makePluginPath "ladspa";
    LV2_PATH = makePluginPath "lv2";
    LXVST_PATH = makePluginPath "lxvst";
    VST_PATH = makePluginPath "vst";
    VST3_PATH = makePluginPath "vst3";
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
    config = { init = { defaultBranch = "main"; }; };
  };

  programs.adb.enable = true;

  programs.appimage.enable = true;

  nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];

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
