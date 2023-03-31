{ pkgs, lib, fetchurl, ... }:

let
  codeium-nvim = pkgs.vimUtils.buildVimPluginFrom2Nix {
    name = "codeium";
    src = pkgs.fetchFromGitHub {
      owner = "jcdickinson";
      repo = "codeium.nvim";
      rev = "55fa67bd316e2a4d312b11d68a2c34f898925a7f";
      hash = "sha256-bmnEaNLxAsGPfiHwmwE/IZvhuBrOcSPFUnP5XCwPutg=";
    };
  };

  codeium = pkgs.stdenv.mkDerivation rec {
    pname = "codeium";
    version = "1.1.69";

    src = pkgs.fetchurl {
      url = "https://github.com/Exafunction/codeium/releases/download/language-server-v${version}/language_server_linux_x64.gz";
      sha256 = "sha256-RK2yjxAC88HT6GuXQRmjiDTbkEBU1vJ3a5N1g48pusM=";
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
