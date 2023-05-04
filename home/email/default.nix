{
  imports = [
    ./accounts.nix
    ./neomutt.nix
  ];

  programs = {
    mbsync.enable = true;
    msmtp.enable = true;
    notmuch = {
      enable = true;
      hooks.preNew = "mbsync --all";
    };
  };

  services = {
    mbsync = {
      enable = true;
      frequency = "5s";
    };
    imapnotify.enable = true;
  };
}
