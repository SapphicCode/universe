{pkgs, ...}: {
  imports = [
    ./minimal.nix
  ];

  home.packages = with pkgs; [
    nushell # crazy powerful shell

    # shell plugins
    zoxide
    atuin

    # fancier TUIs
    btop

    # neovim soft dependencies
    efm-langserver
    fzf
    ripgrep
    ccacheWrapper

    # containers
    podman
    docker-client
    docker-compose

    # tools
    fossil
    hyfetch
    restic
    gnupg
    fq
    just
    halp
    gum
    ## avoid conflict with go-task
    (writeShellScriptBin "taskw" ''
      exec "${pkgs.taskwarrior}/bin/task" "$@"
    '')
  ];
}
