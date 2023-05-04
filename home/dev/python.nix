{ pkgs, ... }:
{
  home.packages = with pkgs; [
    poetry
    (python3.withPackages (p: with p; [ pygame ]))
  ];
}
