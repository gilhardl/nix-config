{
  # Primary user
  system.primaryUser = "gilhardl";

  # Set the primary user
  users.users.gilhardl = {
    uid = 501;
    home = "/Users/gilhardl";
    shell = pkgs.zsh;
  };

  # Set the primary user
  users.knownUsers = [ "gilhardl" ];
}
