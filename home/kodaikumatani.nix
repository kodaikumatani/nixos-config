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
}
