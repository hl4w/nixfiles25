{ config, pkgs, ... }:

{
  environment.variables = {
    GOPROXY = "https://goproxy.cn,direct";
  };
  # 让 nix-daemon 继承全局环境变量
  systemd.services.nix-daemon.environment = config.environment.variables;

  #### AI/机器人开发工具
  environment.systemPackages = with pkgs; [
    #rocmPackages.clr
    #rocmPackages.hiprt
    #rocmPackages.miopen
    #rocmPackages.rccl
    #rocmPackages.rocalution

    # Python
    python313
    python313Packages.pip
    python313Packages.setuptools
    python313Packages.pywal

    poetry
    pipx

    # C++ / ROS Future / go
    gcc
    clang
    cmake
    pkg-config
    go  gopls golangci-lint gofumpt
    #bazel  #仅编译TensorFlow项目时用

    # 科学计算
    #openblas
    #mkl
  ];

}