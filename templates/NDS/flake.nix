{
  description = "NDS Nintendo DS homebrew template";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    devshell.url = "github:numtide/devshell";

    devkitNix.url = "github:bandithedoge/devkitNix";
  };

  outputs =
    {
      nixpkgs,
      devshell,
      devkitNix,
      ...
    }:
    let
      system = "x86_64-linux";

      pkgs = import nixpkgs {
        inherit system;

        overlays = [ devshell.overlays.default ];
      };
    in
    {
      devShells.${system}.default = pkgs.devshell.mkShell {
        packages = [
          devkitNix.packages.${system}.devkitARM

          pkgs.git
          pkgs.gnumake
          pkgs.cmake
          pkgs.python3

          pkgs.melonds
          pkgs.clang-tools
          pkgs.bear
          pkgs.gdb
          pkgs.just
        ];

        env = [
          {
            name = "DEVKITPRO";
            value = "${devkitNix.packages.${system}.devkitARM}/opt/devkitpro";
          }

          {
            name = "DEVKITARM";
            value = "${devkitNix.packages.${system}.devkitARM}/opt/devkitpro/devkitARM";
          }
          {
            name = "PATH";
            prefix = "${devkitNix.packages.${system}.devkitARM}/opt/devkitpro/devkitARM/bin";
          }

          {
            name = "PATH";
            prefix = "${devkitNix.packages.${system}.devkitARM}/opt/devkitpro/tools/bin";
          }
          {
            name = "LIBNDS";
            value = "${devkitNix.packages.${system}.devkitARM}/opt/devkitpro/libnds";
          }
        ];
      };
    };
}
