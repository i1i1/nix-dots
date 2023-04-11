{ pkgs, lib, fetchurl, ... }:

let
  codeium-nvim = pkgs.vimUtils.buildVimPluginFrom2Nix {
    name = "codeium";
    src = pkgs.fetchFromGitHub {
      owner = "jcdickinson";
      repo = "codeium.nvim";
      rev = "92424ea4ba665b76d3287f87f664de244ec6ab78";
      hash = "sha256-7WckEzeyEDf5dm6Tk/DohEFanQPpSdhchnu6Pyhfec0=";
    };
  };

  codeium = pkgs.stdenv.mkDerivation rec {
    pname = "codeium";
    version = "1.1.73";

    src = pkgs.fetchurl {
      url = "https://github.com/Exafunction/codeium/releases/download/language-server-v${version}/language_server_linux_x64.gz";
      sha256 = "sha256-TRuV6OiCOfEd1ExPmSOlO5DooS1r67D8B/vsMUIkho0=";
    };

    unpackPhase = ''
      cp $src codeium.gz
      gzip -d codeium.gz
    '';

    installPhase = ''
      mkdir -p $out/bin
      install -m755 -D codeium $out/bin/codeium
    '';

    nativeBuildInputs = with pkgs; [
      autoPatchelfHook
      gzip
    ];

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
