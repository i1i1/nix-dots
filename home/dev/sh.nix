{ pkgs, ... }:
{
  home.packages = with pkgs; [
    jq
    ltrace
    pup
  ];
}
