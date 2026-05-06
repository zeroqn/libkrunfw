{
  description = "Development shell for building libkrunfw";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs =
    { nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
      python = pkgs.python3.withPackages (pythonPackages: [
        pythonPackages.pyelftools
      ]);
    in
    {
      devShells.${system}.default = pkgs.mkShell {
        packages = (with pkgs; [
          bc
          binutils
          bison
          cpio
          curl
          elfutils
          file
          flex
          gawk
          gcc
          gnumake
          gnugrep
          gnused
          gnutar
          gzip
          ncurses
          openssl
          patch
          perl
          pkg-config
          python
          rsync
          util-linux
          xz
          zlib
        ])
        ++ pkgs.lib.optionals (pkgs ? pahole) [ pkgs.pahole ]
        ++ pkgs.lib.optionals (pkgs ? dwarves) [ pkgs.dwarves ];
      };
    };
}
