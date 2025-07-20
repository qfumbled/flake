{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    rustc
    cargo
  ];

  shellHook = ''
  echo "rust shell also use zeditor for this if your gonna use the terminal go ahead"
  '';
}
