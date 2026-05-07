"  _   _                 _            
" | \ | | ___  _____   _(_)_ __ ___   
" |  \| |/ _ \/ _ \ \ / / | '_ ` _ \  
" | |\  |  __/ (_) \ V /| | | | | | | 
" |_| \_|\___|\___/ \_/ |_|_| |_| |_| 
"                                     
" Author: Silas Zhang (2026) 
" ----------------------------------------------------- 

" 基础设置
set nocompatible            " 关闭 vi 兼容模式
set showmatch               " 高亮匹配括号
set ignorecase              " 搜索忽略大小写
set mouse=v                 " 鼠标中键粘贴
set hlsearch                " 高亮搜索结果
set incsearch               " 实时增量搜索

" 缩进与 Tab 配置
set tabstop=4               " Tab 宽度
set softtabstop=4
set expandtab               " Tab 转为空格
set shiftwidth=4            " 自动缩进宽度
set autoindent              " 自动继承缩进

" 界面与体验
set number                  " 显示行号
set wildmode=longest,list   " 命令行补全模式
set mouse=a                 " 启用鼠标全功能
set clipboard=unnamedplus   " 系统剪贴板互通
set ttyfast                 " 加速滚动

" 语法与文件类型
filetype plugin indent on   " 启用文件类型检测、插件、智能缩进
syntax on                   " 语法高亮

" 可选配置（已注释）
" set cc=80                   " 80 列提示线
" set cursorline              " 高亮当前行
" set spell                   " 拼写检查
" set noswapfile              " 禁用交换文件
" set backupdir=$HOME/.cache/vim  " 备份文件目录