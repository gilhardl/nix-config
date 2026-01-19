{ config, ... }:
{
  homebrew = {
    enable = true;
    brewPrefix = "/opt/homebrew/bin";
    caskArgs.no_quarantine = true;

    onActivation.cleanup = "zap";
    onActivation.autoUpdate = true;
    onActivation.upgrade = true;
    taps = builtins.attrNames config.nix-homebrew.taps;
  };

  nix-homebrew = {
    enable = true;
    enableRosetta = true;
    user = "gilhardl";
    mutableTaps = false; # With mutableTaps disabled, taps can no longer be added imperatively with `brew tap`.
    autoMigrate = true;
    taps = {
      "homebrew/homebrew-core" = {
        url = "https://github.com/homebrew/homebrew-core";
        flake = false;
      };
      "homebrew/homebrew-cask" = {
        url = "https://github.com/homebrew/homebrew-cask";
        flake = false;
      };
      "supabase/tap" = {
        url = "https://github.com/supabase/homebrew-tap";
        flake = false;
      };
    };
  };
}
