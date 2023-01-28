{ ... }:
{
  programs.git = {
    enable = true;
    delta.enable = true;
    userName = "i1i1";
    userEmail = "vanyarybin1@live.ru";
    extraConfig = {
      init = {
        defaultBranch = "master";
      };
    };
    aliases = {
      co = "checkout";
      ci = "commit";
      cia = "commit -a --amend --no-edit";
      st = "status";
      hist = "log --pretty=format:'%C(yellow)[%ad]%C(reset) %C(green)[%h]%C(reset) | %C(red)%s %C(bold red){{%an}}%C(reset) %C(blue)%d%C(reset)' --graph --date=short";
      cl = "clone";
      cld = "clone --depth=1";
    };
  };
}
