{
  description = "Nix package for VideoCaptioner — AI-powered video captioning tool";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    videocaptioner-src = {
      url = "github:WEIFENG2333/VideoCaptioner";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, flake-utils, videocaptioner-src }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      lib = nixpkgs.lib;
      pythonPackages = pkgs.python312Packages;

      pyqt5-frameless-window = pythonPackages.callPackage ./packages/pyqt5-frameless-window { };
      pyqt-fluent-widgets = pythonPackages.callPackage ./packages/pyqt-fluent-widgets {
        inherit pyqt5-frameless-window;
      };

      mkVideocaptioner = cudaSupport:
        (import ./packages/videocaptioner) {
          inherit lib pkgs pythonPackages videocaptioner-src
            pyqt5-frameless-window pyqt-fluent-widgets cudaSupport;
          buildPythonApplication = pythonPackages.buildPythonApplication;
        };
    in {
      packages = {
        inherit pyqt5-frameless-window pyqt-fluent-widgets;

        videocaptioner = mkVideocaptioner false;
        videocaptioner-cuda = mkVideocaptioner true;

        default = self.packages.${system}.videocaptioner-cuda;
      };
    });
}
