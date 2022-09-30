{
  description = "TODO";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = inputs: with inputs; {
    overlays.default = _: prev: {
      TODO = prev.callPackage ./. { };
    };
  } //
  flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs {
        inherit system;
        overlays = [ self.overlays.default ];
      };
    in
    {
      devShells.default = pkgs.mkShell {
        inherit (pkgs.TODO) RUSTFLAGS nativeBuildInputs;
      };
      packages.default = pkgs.TODO;
    });
}
