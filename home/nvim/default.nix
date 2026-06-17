{  config, pkgs,  lib, ... }: 
let

  lazyvim =pkgs.fetchzip {
    url = "https://gitee.com/hl3w/starter/repository/archive/main.zip";
    sha256 = "sha256-f31+UIrjLfwuRBBQLCZZGUW1VDqcflDEC/+bBSYTynE=";
    stripRoot = true;
  };

in {
/*
  home.activation.installNvim = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    mkdir -p $HOME/.config/nvim
    cp -rf ${../nvim}/init.vim $HOME/.config/nvim/init.vim
    find $HOME/.config/nvim -type f -name "*.vim" -exec chmod 644 {} \;
  '';
*/

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
    viAlias = true;
    withNodeJs = true;
    withPython3 = true;
  };


  home.activation.linkLazyVimConfig = lib.hm.dag.entryAfter ["writeBoundary"] ''
    run mkdir -p $HOME/.config/nvim
    TARGET_DIR="$HOME/.config/nvim"

    run cp -rf ${lazyvim}/* "$TARGET_DIR/"
    run chmod -R u+rwX "$TARGET_DIR"
    echo "LazyVim copied to $TARGET_DIR"
  '';
}