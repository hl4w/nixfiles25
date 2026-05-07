{ lib, ... }:

{
  home.activation.installWlogout = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    # 创建主配置目录
    mkdir -p "$HOME/.config/wlogout"

    # 复制核心配置文件
    cp -rf "${../wlogout}/layout" "$HOME/.config/wlogout/"
    cp -rf "${../wlogout}/style.css" "$HOME/.config/wlogout/"
    cp -rf "${../wlogout}/noise.png" "$HOME/.config/wlogout/"

    # 设置主目录文件权限
    find "$HOME/.config/wlogout" -type f -exec chmod 644 {} \;

    # 复制图标文件
    mkdir -p "$HOME/.config/wlogout/icons"
    cp -rf "${./icons}/"* "$HOME/.config/wlogout/icons/"

    # 设置图标文件权限
    find "$HOME/.config/wlogout/icons" -type f -exec chmod 644 {} \;
  '';
}