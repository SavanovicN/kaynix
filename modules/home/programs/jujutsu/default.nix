{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.kaynix.programs.jujutsu;
in {
  options.kaynix.programs.jujutsu = {
    enable = lib.mkEnableOption "jujutsu (jj)";
  };

  config = lib.mkIf cfg.enable {
    programs.jujutsu = {
      enable = true;
      settings = {
        user = {
          name = "SavanovicN";
          email = "nikola.savanovic.tl@gmail.com";
        };
        fetch.prune = true;
        init.default_branch = "main";
        lfs.enabled = true;
        signing = {
          backend = "ssh";
          key = "${config.home.homeDirectory}/.ssh/id_rsa.pub";
        };
        push = {
          autoSetupRemote = true;
          default = "current";
        };
        rebase.auto_stash = true;
        ui.default-command = "log";
      };
    };

    home.shellAliases = lib.mkIf pkgs.stdenv.isDarwin {
      jj = "RAYON_NUM_THREADS=4 command jj";
    };
  };
}
