{ pkgs, lib, fetchurl, ... }:

let
  codeium-nvim = pkgs.vimUtils.buildVimPluginFrom2Nix {
    name = "codeium";
    src = pkgs.fetchFromGitHub {
      owner = "jcdickinson";
      repo = "codeium.nvim";
      rev = "de7c4d17f5b10e6c38b3c68d3472fffca984acae";
      hash = "sha256-Wnc3k1gHVC/QQp6aqasYW7ABc+Knr2IQ8U6Lm35c0vE=";
    };
  };

  codeium = pkgs.stdenv.mkDerivation rec {
    pname = "codeium";
    version = "1.1.42";

    src = pkgs.fetchurl {
      url = "https://github.com/Exafunction/codeium/releases/download/language-server-v${version}/language_server_linux_x64.gz";
      sha256 = "sha256-sT0XoeXXMAJzZ/fMuWa4ukBceqInhn107cgUogdZnfg=";
    };

    unpackPhase = ''
      cp $src codeium.gz
      gzip -d codeium.gz
    '';

    installPhase = ''
      mkdir -p $out/bin
      install -m755 -D codeium $out/bin/codeium
    '';

    nativeBuildInputs = with pkgs; [ autoPatchelfHook gzip ];

    meta = with lib; {
      homepage = "https://codeium.com";
      description = "Codeium is the modern coding superpower, a code acceleration toolkit built on cutting edge AI technology.";
      platforms = platforms.linux;
    };
  };
in
{
  home.packages = [ codeium ];

  programs.nixvim = {
    # UI for nvim-lsp progress (for example rust-analyzer compilation progress)
    extraPlugins = [ pkgs.vimPlugins.nui-nvim codeium-nvim ];
    extraConfigLua = ''
      require"codeium".setup({ ["tools"] = { ["language_server"] = "${codeium.outPath}/bin/codeium" } })
    '';
  };
}
