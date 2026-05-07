{ lib, ... }: 

{
  home.activation.installWall = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    mkdir -p $HOME/wallpaper
    cp -rf ${./wallpapers}/*  $HOME/wallpaper/
    find $HOME/wallpaper -type f -exec chmod 644 {} \;
  '';
}
