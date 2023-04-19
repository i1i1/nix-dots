{ pkgs, ... }:
{
  programs.vscode = {
    extensions = with pkgs.vscode-marketplace; [
      rust-lang.rust-analyzer
      vadimcn.vscode-lldb
      serayuzgur.crates
    ];
    userSettings = {
      "rust-analyzer.server.path" = "/home/i1i1/.rustup/toolchains/nightly-2023-04-02-x86_64-unknown-linux-gnu/bin/rust-analyzer";
    };
  };
}
