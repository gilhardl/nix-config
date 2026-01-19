{
  # Enable ZSH shell
  programs.zsh.enable = true;

  # Set the shells
  environment.shells = with pkgs; [
    bash
    zsh
  ];
}
