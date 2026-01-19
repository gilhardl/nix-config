{ pkgs, ... }:
{
  systemPackages = pkgs: [
    pkgs.alacritty
    pkgs.ffmpeg
    pkgs.fzf
    pkgs.git
    pkgs.git-lfs
    pkgs.htop
    pkgs.neovim
    pkgs.nixfmt
    pkgs.nodejs_24
    pkgs.obsidian
    pkgs.supabase-cli
    pkgs.swiftformat
    pkgs.tmux
    pkgs.tree
    pkgs.yt-dlp
    pkgs.zoxide
  ];

  homebrew = {
    brews = [ "mas" ];
    casks = [
      "cursor"
      "discord"
      "docker"
      "docker-desktop"
      "figma"
      "github"
      "google-chrome"
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
    ];
    masApps = {
      "Xcode" = 497799835;
      "Swift Playgrounds" = 1496833156;
      "Apple Developer" = 640199958;
      "CANAL+" = 694580816;
      "Perplexity: Ask Anything" = 6714467650;
      "WhatsApp Messenger" = 310633997;
      "Affinity Designer 2" = 1616831348;
      "NordVPN : VPN ultra-rapide" = 905953485;
      "Bitwarden" = 1137397744; # TODO : remove when all passwords will be migrated
    };
  }
}
