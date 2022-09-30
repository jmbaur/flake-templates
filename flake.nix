{
  description = "Flake Templates";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "nixpkgs/nixos-unstable";
    pre-commit-hooks.inputs.nixpkgs.follows = "nixpkgs";
    pre-commit-hooks.url = "github:cachix/pre-commit-hooks.nix";
  };

  outputs = inputs: with inputs; {
    templates = {
      golang = { description = "golang"; path = ./golang; };
      rust = { description = "rust"; path = ./rust; };
    };
  }
  // flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs { inherit system; };
      preCommitHooks = pre-commit-hooks.lib.${system}.run {
        src = ./.;
        hooks.nixpkgs-fmt.enable = true;
      };
    in
    {
      devShells.default = pkgs.mkShell { inherit (preCommitHooks) shellHook; };
    });
}
