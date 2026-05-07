{  pkgs,  config, lib, ... }: 
{
  home.activation.installSettings = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    mkdir -p $HOME/.config/settings

    # 复制配置文件
    cp -rf ${../settings}/configs/* $HOME/.config/settings/

    # 统一设置权限
    find $HOME/.config/settings -type f -name "*.sh" -exec chmod 755 {} \;
    find "$HOME/.config/settings" -type f \( -name "*.rasi" -o -name "*.tpl" \) -exec chmod 644 {} \;
  '';
}