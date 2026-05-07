{  config, pkgs,  lib, ... }: 

{
  home.activation.installDunst = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    mkdir -p $HOME/.config/dunst
    cp -rf ${../dunst}/dunstrc $HOME/.config/dunst/
    find $HOME/.config/dunst -type f  -exec chmod 644 {} \;
  '';
}