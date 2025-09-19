{
  description = "Lucas's Nix configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
    homebrew-core-tap = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask-tap = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
    supabase-tap = {
      url = "github:supabase/homebrew-tap";
      flake = false;
    };
  };

  outputs =
    inputs@{
      self,
      nix-darwin,
      nixpkgs,
      nix-homebrew,
      homebrew-core-tap,
      homebrew-cask-tap,
      supabase-tap,
    }:
    let
      configuration =
        { pkgs, ... }:
        {
          nixpkgs.config.allowUnfree = true;

          # List packages installed in system profile. To search by name, run:
          # $ nix-env -qaP | grep wget
          environment.systemPackages = [
            pkgs.alacritty
            pkgs.neovim
            pkgs.nodejs_24
            pkgs.fzf
            pkgs.tmux
            pkgs.git
            pkgs.git-lfs
            pkgs.zoxide
          ];

          # Homebrew packages
          homebrew = {
            onActivation.cleanup = "zap";
            onActivation.autoUpdate = true;
            onActivation.upgrade = true;
            brews = [
              "ffmpeg"
              "fzf"
              "htop"
              "mas"
              "nixfmt"
              "supabase"
              "stow"
              "swiftformat"
              "tree"
              "yt-dlp"
              "zoxide"
            ];
            casks = [
              "affinity-designer"
              "bitwarden"
              "cursor"
              "discord"
              "docker"
              "docker-desktop"
              "figma"
              "github"
              "google-chrome"
              "nordvpn"
              "onyx"
              "postman"
              "sanesidebuttons"
              "scroll-reverser"
              "sf-symbols"
              "visual-studio-code"
              "tor-browser"
              "tradingview"
              "transmission"
              "utm"
              "vlc"
              "whatsapp"
            ];
            masApps = {
              "Xcode" = 497799835;
              "Perplexity: Ask Anything" = 6714467650;
              "Apple Developer" = 640199958;
              "CANAL+" = 694580816;
              "Swift Playgrounds" = 1496833156;
            };
          };

          # Fonts
          fonts.packages = [
            # Alacritty font
            pkgs.nerd-fonts.jetbrains-mono
          ];

          system.primaryUser = "gilhardl";

          system.defaults = {
            dock = {
              show-recents = false;
              minimize-to-application = true;
            };
          };

          # Necessary for using flakes on this system.
          nix.settings.experimental-features = "nix-command flakes";

          # Enable alternative shell support in nix-darwin.
          # programs.fish.enable = true;
          programs.zsh.enable = true;

          # Set Git commit hash for darwin-version.
          system.configurationRevision = self.rev or self.dirtyRev or null;

          # Used for backwards compatibility, please read the changelog before changing.
          # $ darwin-rebuild changelog
          system.stateVersion = 6;

          # The platform the configuration will be used on.
          nixpkgs.hostPlatform = "aarch64-darwin";
        };
    in
    {
      # Build darwin flake using:
      # $ darwin-rebuild build --flake .#simple
      darwinConfigurations.mbp = nix-darwin.lib.darwinSystem {
        modules = [
          configuration
          nix-homebrew.darwinModules.nix-homebrew
          {
            nix-homebrew = {
              # Install Homebrew under the default prefix
              enable = true;
              # Apple Silicon Only: Also install Homebrew under the default Intel prefix for Rosetta 2
              enableRosetta = true;
              # User owning the Homebrew prefix
              user = "gilhardl";
              # Optional: Declarative tap management
              taps = {
                "homebrew/homebrew-core" = homebrew-core-tap;
                "homebrew/homebrew-cask" = homebrew-cask-tap;
                "supabase/tap" = supabase-tap;
              };
              # Optional: Enable fully-declarative tap management
              #
              # With mutableTaps disabled, taps can no longer be added imperatively with `brew tap`.
              mutableTaps = false;

              autoMigrate = true;
            };
          }
          # Optional: Align homebrew taps config with nix-homebrew
          (
            { config, ... }:
            {
              homebrew.taps = builtins.attrNames config.nix-homebrew.taps;
            }
          )
        ];
      };
    };
}
