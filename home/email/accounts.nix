{ pkgs, ... }:
let
  generic = {
    realName = "Ivan";
    signature = {
      text = ''
        Regards,
        Ivan
      '';
      showSignature = "append";
    };

    mbsync = {
      enable = true;
      create = "maildir";
    };
    msmtp.enable = true;
    neomutt.enable = true;
    imapnotify = {
      enable = true;
      onNotifyPost = {
        mail = "${pkgs.notmuch}/bin/notmuch new && ${pkgs.libnotify}/bin/notify-send 'New mail arrived'";
      };
    };
    notmuch = {
      enable = true;
      neomutt.enable = true;
    };
  };
in
{
  accounts.email.accounts = {
    live = generic // {
      primary = true;
      address = "vanyarybin1@live.ru";
      userName = "vanyarybin1@live.ru";
      imap = {
        host = "outlook.office365.com";
        tls.enable = true;
      };
      passwordCommand = "rbw get --folder mail live";
      smtp = {
        host = "smtp.office365.com";
        tls = {
          enable = true;
          useStartTls = true;
        };
      };
    };
  };
}
