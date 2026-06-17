{
  description = "NixOS 25.11 Flake Configuration";

  # ============================================================================
  # Nix 配置选项
  # ============================================================================
  # 这些配置会影响 nix 命令的行为和包获取策略
  nixConfig = {
    # 启用实验性功能：nix-command 和 flakes 支持
    experimental-features = [ "nix-command" "flakes" ];

    # 包下载源（按优先级排序）
    # 1. 清华大学镜像 - 国内访问速度快
    # 2. 中国科学技术大学镜像 - 备用镜像
    # 3. 官方 Nix 缓存 - 兜底方案
    substituters = [
      "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
      "https://mirrors.ustc.edu.cn/nix-channels/store"
      "https://cache.nixos.org/"
    ];

    # 信任的下载源（无需签名验证即可使用）
    trusted-substituters = [
      "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
      "https://mirrors.ustc.edu.cn/nix-channels/store"
    ];
  };

  # ============================================================================
  # 输入源配置
  # ============================================================================
  # 定义项目依赖的所有外部 flake
  inputs = {
    # NixOS 主包仓库（使用官方 25.11 分支）
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";

    # Home Manager - 用户配置管理工具
    # 用于管理用户级应用和配置
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";  # 与 nixpkgs 保持同步
    };

    # Noctalia Shell - 定制化 shell 环境
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Hyprland 社区贡献工具集
    # 提供额外的 Hyprland 相关工具和脚本
    hyprland-contrib = {
      url = "github:hyprwm/hyprland-contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  # ============================================================================
  # 输出配置
  # ============================================================================
  outputs = { self, nixpkgs, home-manager, noctalia, hyprland-contrib, ... }@inputs:
    let
      # 系统架构
      system = "x86_64-linux";

      # 用户名和主机名
      # 这些值可通过 install.sh 脚本自动配置
      # 修改后需重新运行 nixos-rebuild switch --flake .#<hostname>
      username = "silas";
      hostname = "nixos";

      # 传递给所有模块的特殊参数
      specialArgs = { inherit username hostname; };

      # 预导入的包集合（用于 formatter）
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;  # 允许使用非自由软件
      };
    in {
      # ==========================================================================
      # NixOS 系统配置
      # ==========================================================================
      # 定义名为 "nixos" 的系统配置
      nixosConfigurations."${hostname}" = nixpkgs.lib.nixosSystem {
        inherit system specialArgs;  # 继承系统架构和特殊参数

        modules = [
          ./hosts                  # 主机级配置
          ./users/nixos.nix        # 用户配置

          # Home Manager 模块集成
          home-manager.nixosModules.home-manager
          {
            # Home Manager 全局配置
            home-manager.useGlobalPkgs = true;      # 使用系统的 nixpkgs
            home-manager.useUserPackages = true;     # 使用用户包管理
            home-manager.extraSpecialArgs = inputs // specialArgs;  # 传递所有输入和参数
            home-manager.users.${username} = import ./users/home.nix;  # 用户 Home Manager 配置
          }
        ];
      };

      # ==========================================================================
      # 代码格式化工具
      # ==========================================================================
      # 提供 nix fmt 命令来格式化 Nix 代码
      formatter."${system}" = pkgs.nixpkgs-fmt;
    };
}
