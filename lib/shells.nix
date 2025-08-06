# ./lib/shells.nix
{pkgs}: {
  default = pkgs.mkShell {
    packages = with pkgs; [
      rust-bin.beta.latest.default
      rust-analyzer
      pkg-config
      openssl
      clang
    ];

    shellHook = ''

    '';
  };
}
