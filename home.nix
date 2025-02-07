{ config, pkgs, inputs, ... }:

{
  imports = [
    ./hyprland.nix
    ./lf.nix
    ./nixvim.nix
    inputs.nixvim.homeManagerModules.nixvim
  ];

  home.username = "rot10rin5";
  home.homeDirectory = "/home/rot10rin5";

  home.stateVersion = "24.11";

  home.packages = [
  ];

  home.file = {
  };

  home.sessionVariables = {
  };

  programs.home-manager.enable = true;

  programs.kitty.enable = true;
  programs.waybar.enable = true;

  programs.git = {
    enable = true;
    userName  = "rot10rin5";
    userEmail = "rot10rin5@gmail.com";
  };
}
