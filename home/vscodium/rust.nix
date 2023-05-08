{ pkgs, ... }:
{
  programs.vscode = {
    extensions = with pkgs.vscode-marketplace; [
      rust-lang.rust-analyzer
      # vadimcn.vscode-lldb
      serayuzgur.crates
    ];
    userSettings = {
      "rust-analyzer.server.path" = "/home/i1i1/.rustup/toolchains/nightly-2023-04-02-x86_64-unknown-linux-gnu/bin/rust-analyzer";

      "[rust]" = {
        "editor.fontLigatures" = true;
        "editor.formatOnSave" = true;
      };

      # use clippy over cargo check
      "rust-analyzer.check.command" = "clippy";

      # use nightly range formatting, should be faster
      "rust-analyzer.rustfmt.rangeFormatting.enable" = true;

      # use lldb for debugging
      "rust-analyzer.debug.engine" = "vadimcn.vscode-lldb";

      # show references for everything
      "rust-analyzer.hover.actions.references.enable" = true;
      "rust-analyzer.lens.references.adt.enable" = true;
      "rust-analyzer.lens.references.enumVariant.enable" = true;
      "rust-analyzer.lens.references.method.enable" = true;
      "rust-analyzer.lens.references.trait.enable" = true;

      # show hints for elided lifetimes
      "rust-analyzer.inlayHints.lifetimeElisionHints.enable" = "always"; # or 'skip_trivial'
    };
  };
}
