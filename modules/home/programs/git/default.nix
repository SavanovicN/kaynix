{
  config,
  lib,
  pkgs,
  kaynixStatic,
  ...
}: let
  cfg = config.kaynix.programs.git;
in {
  options.kaynix.programs.git = {
    enable = lib.mkEnableOption "git";
  };

  config = lib.mkIf cfg.enable {
    home.file.".gitignore_global".source = "${kaynixStatic}/git/ignore_global";

    programs.git = {
      enable = true;
      lfs.enable = true;
      signing = {
        format = "ssh";
        signByDefault = true;
        key = "${config.home.homeDirectory}/.ssh/id_rsa.pub";
      };
      settings = {
        user = {
          name = "SavanovicN";
          email = "nikola.savanovic.tl@gmail.com";
        };
        credential = lib.mkIf pkgs.stdenv.isDarwin {helper = "osxkeychain";};
        push = {autoSetupRemote = true;};
        init = {defaultBranch = "main";};
        core = {
          excludesFile = "${config.home.homeDirectory}/.gitignore_global";
          autocrlf = "input";
        };
        advice = {detachedHead = false;};
        http = {postBuffer = "524288000";};
      };
    };
  };
}
