{ pkgs, ... }:
{
  home.packages = [ pkgs.tdesktop ];

  xdg.desktopEntries.telegram = {
    name = "Telegram Desktop";
    comment = "Custom definition for Telegram Desktop";
    exec = "telegram-desktop -workdir /home/i1i1/.local/share/TelegramDesktop/ -- %u";
    type = "Application";
    mimeType = [ "x-scheme-handler/tg" ];
  };
  xdg.mimeApps.defaultApplications."x-scheme-handler/tg" = "telegram.desktop";
}
