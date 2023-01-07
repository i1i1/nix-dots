#!/bin/sh
sudo nixos-rebuild switch -I nixos-config=$HOME/.dotfiles/system/configuration.nix
