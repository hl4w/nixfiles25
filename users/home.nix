{pkgs, ...}: 
{
  ##################################################################################################################
  #
  # All Silas's Home Manager Configuration
  #
  ##################################################################################################################

  imports = [
    ../home/core.nix
    ../home/programs

    ../home/fcitx5
    ../home/hypr
    ../home/waybar
    ../home/rofi
    ../home/scripts
    ../home/settings
    ../home/starship
    ../home/swappy
    ../home/wal
    ../home/wallpapers
    ../home/nvim
    ../home/dunst
    ../home/wlogout

    ../home/shell
    

  ];

  programs.git = {
    enable = true;
    settings.user.name = "Silas Zhang";
    settings.user.email = "silaszk@126.com";
  };

}
