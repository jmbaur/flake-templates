{ buildGoModule, lib, ... }:
buildGoModule {
  pname = "TODO";
  version = "0.1.0";
  src = ./.;
  vendorSha256 = lib.fakeSha256;
  CGO_ENABLED = 0;
}
