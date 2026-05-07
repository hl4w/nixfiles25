{  config, pkgs,  lib, ... }: 

{
  home.activation.installNvim = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    mkdir -p $HOME/.config/nvim
    cp -rf ${../nvim}/init.vim $HOME/.config/nvim/init.vim
    find $HOME/.config/nvim -type f -name "*.vim" -exec chmod 644 {} \;
  '';
}