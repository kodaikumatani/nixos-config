{ config, pkgs, ... }:

{
  home.username = "kodaikumatani";
  home.homeDirectory = "/home/kodaikumatani";
  home.stateVersion = "25.11";

  home.packages = with pkgs; [
    cursor-cli
    (writeShellScriptBin "agent" ''
      exec "${cursor-cli}/bin/cursor-agent" "$@"
    '')
    google-chrome
  ];

  programs.bash.enable = true;

  programs.git = {
    enable = true;
    userName = "kodaikumatani";
    userEmail = "koudai.aco5423@gmail.com";
    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = false;
      push.autoSetupRemote = true;
    };
  };

  programs.home-manager.enable = true;
}
