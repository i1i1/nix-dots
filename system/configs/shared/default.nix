{ pkgs, ... }:
{
  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
      substituters = [
        "https://nix-gaming.cachix.org"
        "https://colmena.cachix.org"
        "https://i1i1-colmena.cachix.org"
      ];
      trusted-public-keys = [
        "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
        "colmena.cachix.org-1:7BzpDnjjH8ki2CT3f6GdOk7QAzPOl+1t3LvTLXqYcSg="
        "i1i1-colmena.cachix.org-1:YrxuNyeY5PXrwlOWrjKysLHotY/dbgM39dpD4GBp/0U="
      ];
      trusted-users = [ "root" "i1i1" ];
    };

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  features.networking.wireguard = {
    enable = true;
    keyCommand = [ "rbw" "get" "--folder" "wireguard" "client0" ];
    pubkey = "zQpLCtbX/Lu1pmsFDArrmrqe0Cu1AvaM9g59fiPkeHw=";
    endpoint = "sx.thatsverys.us:51820";
  };

  # Pick only one of the below networking options.
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Moscow";

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    libinput.enable = true;
    displayManager.defaultSession = "none+fake";
    displayManager.session = [{
      manage = "window";
      name = "fake";
      start = "";
    }];
  };

  hardware.pulseaudio.enable = true;

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true; # use xkbOptions in tty.
  };

  # Enable sound.
  sound.enable = true;

  hardware.opengl = {
    enable = true;
    driSupport = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.mutableUsers = true;
  users.users.i1i1 = {
    isNormalUser = true;
    hashedPassword =
      "$6$hmYNQ2jo5Z70p2Am$tvp6rq2lly1iaMgAQgOq03ZWyA29ZKwKrUOUNZvuEDqg1ot2AUCS762JPpzEWfVLnGSaBgIiaFqxnSwS4fkGv1";
    extraGroups = [ "wheel" "networkmanager" "docker" ];
    shell = pkgs.fish;
  };
  programs.fish.enable = true;

  security.sudo = {
    enable = true;
    execWheelOnly = true;
    extraConfig = ''
      Defaults  lecture="never"
    '';
  };

  environment.shells = [ ];
  environment.systemPackages = [ ];

  virtualisation.docker.enable = true;

  networking.stevenBlackHosts = {
    enable = true;
    blockFakenews = true;
    blockGambling = true;
    blockPorn = true;
    blockSocial = true;
  };
}
