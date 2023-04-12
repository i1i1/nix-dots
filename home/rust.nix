{ pkgs, ... }:
{
  home.file.".cargo/config.toml".text = ''
    [build]
    rustflags = ["-C", "target-cpu=native", "--cfg", "tokio_unstable"]

    [target.x86_64-unknown-linux-gnu]
    linker = "clang"
    rustflags = ["-C", "target-cpu=native", "-C", "link-arg=-fuse-ld=mold", "--cfg", "tokio_unstable"]
  '';
  home.packages = with pkgs; [
    clang
    cmake
    gnumake
    llvm
    llvm.dev
    mold
    protobuf3_20
    rustup
  ];
}
