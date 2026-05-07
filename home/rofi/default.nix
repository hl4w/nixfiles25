{  lib,  ... }: 
{
  home.activation.installRofi = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    mkdir -p $HOME/.config/rofi
    cp -rf ${../rofi}/configs/* $HOME/.config/rofi/
    find $HOME/.config/rofi -type f -name "*.rasi" -exec chmod 644 {} \;
  '';
}