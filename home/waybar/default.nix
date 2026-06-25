{ lib, ... }:

{
  home.activation.installWaybar = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    # 主目录
    mkdir -p "$HOME/.config/waybar"

    # 复制脚本并赋予执行权限
    cp -rf "${../waybar}/launch.sh" "$HOME/.config/waybar/"
    cp -rf "${../waybar}/themeswitcher.sh" "$HOME/.config/waybar/"
    find "$HOME/.config/waybar" -type f -name "*.sh" -exec chmod 755 {} \;

    # 复制配置文件并赋予只读权限
    cp -rf "${../waybar}/modules.json" "$HOME/.config/waybar/"
    chmod 644 "$HOME/.config/waybar/modules.json"

    # 复制主题目录
    mkdir -p "$HOME/.config/waybar/themes"
    cp -rf "${../waybar}/themes/"* "$HOME/.config/waybar/themes/"
    find "$HOME/.config/waybar/themes" -type d -exec chmod 755 {} \;

    # 主题文件权限：默认 644，脚本 755
    find "$HOME/.config/waybar/themes" -type f -exec chmod 644 {} \;
    find "$HOME/.config/waybar/themes" -type f -name "*.sh" -exec chmod 755 {} \;
  '';
}