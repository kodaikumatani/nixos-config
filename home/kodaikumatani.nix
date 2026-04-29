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
    discord
  ];

  programs.bash.enable = true;

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "kodaikumatani";
        email = "koudai.aco5423@gmail.com";
      };
      init.defaultBranch = "main";
      pull.rebase = false;
      push.autoSetupRemote = true;
    };
  };

  programs.home-manager.enable = true;
}
