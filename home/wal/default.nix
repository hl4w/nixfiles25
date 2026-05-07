{  config, pkgs, lib, ... }: 

{
  home.activation.installWal = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    mkdir -p $HOME/.config/wal/templates
    cp -rf ${./templates}/* $HOME/.config/wal/templates/
    find $HOME/.config/wal/templates -type f -exec chmod 644 {} \;
  '';
}
