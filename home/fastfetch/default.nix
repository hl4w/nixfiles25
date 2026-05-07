{  config, pkgs,  lib, ... }: 

{
  home.activation.installFastfetch = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    mkdir -p $HOME/.config/fastfetch
    cp -rf ${../fastfetch}/config.jsonc $HOME/.config/fastfetch/config.jsonc
    find $HOME/.config/fastfetch -type f -name "*.jsonc" -exec chmod 644 {} \;
  '';
}