{
  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  # Necessary for installing unfree packages.
  nixpkgs.config.allowUnfree = true;

  # Set Git commit hash for darwin-version.
  system.configurationRevision = self.rev or self.dirtyRev or null;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 6;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";

  # Paths to link to /run/current-system/sw/
  pathsToLink = [ "/Applications" ];

  # Fonts
  fonts.packages = [
    pkgs.nerd-fonts.jetbrains-mono
  ];

  imports = [
    ./shell.nix
    ./user.nix
    ./homebrew.nix
    ./packages.nix
    ./macos.nix
  ];
}
