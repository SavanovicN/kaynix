{
  config,
  lib,
  pkgs,
  username,
  hostConfig,
  ...
}: {
  imports = [
    ../modules/home
    # sops-nix is disabled until a personal age/YubiKey identity is set up.
    # The encrypted secrets/secrets.yaml still belongs to the upstream owner;
    # re-key it (see secrets/README.md) and re-add ./sops.nix to enable.
    # ./sops.nix
  ];

  programs.home-manager.enable = true;

  home.username = username;
  home.homeDirectory =
    if pkgs.stdenv.isDarwin
    then "/Users/${username}"
    else "/home/${username}";
  home.stateVersion = hostConfig.homeStateVersion or "24.11";

  xdg.enable = true;

  home.sessionPath = [
    "${config.home.homeDirectory}/.cargo/bin"
    "${config.home.homeDirectory}/go/bin"
    "${config.home.homeDirectory}/.local/bin"
  ];

  kaynix.programs = {
    # Disabled: symlinks ~/.cursor/skills and ~/.claude/skills to a checkout of
    # kaynetik-skills that does not exist here. Enable once you have your own.
    agents.enable = lib.mkDefault false;
    atuin.enable = lib.mkDefault true;
    eza.enable = lib.mkDefault true;
    fzf.enable = lib.mkDefault true;
    gh.enable = lib.mkDefault true;
    git.enable = lib.mkDefault true;
    java.enable = lib.mkDefault true;
    jjui.enable = lib.mkDefault true;
    jujutsu.enable = lib.mkDefault true;
    k9s.enable = lib.mkDefault true;
    lazygit.enable = lib.mkDefault true;
    neovim.enable = lib.mkDefault true;
    sketchybar.enable = lib.mkDefault pkgs.stdenv.isDarwin;
    ssh.enable = lib.mkDefault true;
    terminals.enable = lib.mkDefault true;
    yazi.enable = lib.mkDefault true;
    zoxide.enable = lib.mkDefault true;
    zsh.enable = lib.mkDefault true;
  };
}
