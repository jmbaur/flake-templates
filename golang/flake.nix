{
  description = "TODO";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    pre-commit-hooks.inputs.nixpkgs.follows = "nixpkgs";
    pre-commit-hooks.url = "github:cachix/pre-commit-hooks.nix";
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
      preCommitHooks = pre-commit-hooks.lib.${system}.run {
        src = ./.;
        hooks = {
          nixpkgs-fmt.enable = true;
          gofmt = {
            enable = true;
            entry = "${pkgs.gobar.go}/bin/gofmt -w";
            types = [ "go" ];
          };
        };
      };
    in
    {
      devShells.default = pkgs.mkShell {
        inherit (pkgs.TODO) CGO_ENABLED nativeBuildInputs;
        inherit (preCommitHooks) shellHook;
      };
      packages.default = pkgs.TODO;
    });
}
