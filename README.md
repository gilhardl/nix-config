# Nix Config

This is my personal Nix configuration.

## Target system

- MacBook Pro (M1 Pro) - MacOS Tahoe 26

## Installation

1. Install Nix package manager

```sh
curl -L https://nixos.org/nix/install | sh
```

2. Download Nix configuration

```sh
nix-shell -p git --run "git clone https://github.com/gilhardl/nix-config.git ~/nix"
```

3. Install Nix flake

```sh
nix run nix-darwin --extra-experimental-features 'nix-command flakes' -- switch --flake ~/nix#mbp
```

## Upgrade packages

1. Update flake

```sh
cd ~/nix && nix flake update
```

2. Rebuild system

```sh
darwin-rebuild switch --flake ~/nix#mbp
```

## Customize configuration

1. Edit `flake.nix`

2. Rebuild system

```sh
darwin-rebuild switch --flake ~/nix#mbp
```
