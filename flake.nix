{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };
  outputs = { nixpkgs, ... }@inputs: {
    packages.x86_64-linux = let
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
    in rec {
      mavica-set-metadata = pkgs.callPackage ./package/set-metadata.nix {};
      mavica-portrait = pkgs.callPackage ./package/portrait.nix { };
      mavica-ingest = pkgs.callPackage ./package/ingest.nix {
        inherit mavica-set-metadata mavica-portrait;
      };
      default = mavica-ingest;
    };
  };
}
