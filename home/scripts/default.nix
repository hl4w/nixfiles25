{ lib, ... }: 
{
  home.activation.installScripts = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    mkdir -p $HOME/.config/scripts

    # 复制配置脚本
    cp -rf ${../scripts}/configs/* $HOME/.config/scripts/

    # 给所有脚本执行权限
    find "$HOME/.config/scripts" \
      -type f \
      \( -name "*.sh" -o -name "*.py" \) \
      -exec chmod 755 {} \;
  '';
}