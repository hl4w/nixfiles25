{  lib, ... }: 

{
  home.activation.installStarship = lib.hm.dag.entryAfter [ "writeBoundary" ] ''

    # 创建目录并复制配置文件
    mkdir -p $HOME/.config/starship
    cp -rf ${../starship}/starship.toml $HOME/.config/starship/

    # 设置文件权限
    find $HOME/.config/starship -type f -name "*.toml" -exec chmod 644 {} \;
  '';
}