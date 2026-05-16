{ config, pkgs, dotfiles, ... }:

{
  home.username = "kodaikumatani";
  home.homeDirectory = "/home/kodaikumatani";
  home.stateVersion = "25.11";

  home.packages = with pkgs; [
    neovim
    gh
    ghq
    fzf
    tmux
    ghostty
    starship
    mise
    lsof
    kubectl
    cursor-cli
    (writeShellScriptBin "agent" ''
      exec "${cursor-cli}/bin/cursor-agent" "$@"
    '')
    google-chrome
    discord
    claude-code
  ];

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    initContent = ''
      source ${config.xdg.configHome}/zsh/git-ghq.zsh
      eval "$(starship init zsh)"
    '';
  };

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

  xdg.configFile = {
    "starship.toml".source = "${dotfiles}/.config/starship.toml";
    "ghostty/config".source = "${dotfiles}/.config/ghostty/config";
    "tmux/tmux.conf".source = "${dotfiles}/.config/tmux/tmux.conf";
    "tmux/sessionizer.sh" = {
      source = "${dotfiles}/.config/tmux/sessionizer.sh";
      executable = true;
    };
    "nvim".source = "${dotfiles}/.config/nvim";
    "zsh/git-ghq.zsh".source = "${dotfiles}/.config/zsh/git-ghq.zsh";
  };

  programs.home-manager.enable = true;

  programs.plasma = {
    enable = true;
    shortcuts = {
      kwin = {
        "Show Desktop" = "none";
        "Overview" = "none";
        "Edit Tiles" = "none";
        "Window Close" = "none";
        "Switch to Desktop 1" = "none";
        "Switch to Desktop 2" = "none";
        "Switch to Desktop 3" = "none";
        "Switch to Desktop 4" = "none";
        "Switch to Desktop 5" = "none";
        "Switch to Desktop 6" = "none";
        "Switch to Desktop 7" = "none";
        "Switch to Desktop 8" = "none";
        "Switch to Desktop 9" = "none";
      };
      plasmashell = {
        "activate task manager entry 1" = "none";
        "activate task manager entry 2" = "none";
        "activate task manager entry 3" = "none";
        "activate task manager entry 4" = "none";
        "activate task manager entry 5" = "none";
        "activate task manager entry 6" = "none";
        "activate task manager entry 7" = "none";
        "activate task manager entry 8" = "none";
        "activate task manager entry 9" = "none";
      };
      kscreen = {
        "Display" = "none";
      };
    };
  };
}
