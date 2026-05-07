{ config, pkgs, lib, ... }: 

{
  programs.swappy = {
    enable = true;
  };

  home.activation.installSwappy = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    mkdir -p $HOME/.config/swappy
    cp -rf ${../swappy}/config $HOME/.config/swappy/
    chmod 644  $HOME/.config/swappy/config
  '';
}
