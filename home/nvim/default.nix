{  config, pkgs,  lib, ... }: 

{
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


  lazyvim =pkgs.fetchzip {
    url = "https://gitee.com/hl4w/starter/repository/archive/main.zip";
    sha256 = lib.fakeSha256;
    stripRoot = true;
  };

  home.activation.linkLazyVimConfig = lib.hm.dag.entryAfter ["writeBoundary"] ''
    run mkdir -p $HOME/.config/nvim
    TARGET_DIR="$HOME/.config/nvim"

    run cp -rf ${lazyvim}/* "$TARGET_DIR/"
    run chmod -R u+rwX "$TARGET_DIR"
    echo "LazyVim copied to $TARGET_DIR"
  '';
}