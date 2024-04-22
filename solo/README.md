# NvimCode

把 nvim 配置为主力开发环境，逐步替代 VSCode.

## 安装 - 准备工作

### 安装插件管理器

使用 [vim-plug](https://github.com/junegunn/vim-plug)

```bash
# export HTTPS_PROXY=127.0.0.1:port # optional
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
```

powershell(admin):
```pwsh
iwr -useb https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim |`
    ni "$(@($env:XDG_DATA_HOME, $env:LOCALAPPDATA)[$null -eq $env:XDG_DATA_HOME])/nvim-data/site/autoload/plug.vim" -Force
```

### 安装 rigrep

https://github.com/BurntSushi/ripgrep

用于 Telescope 的 live_grep 和 live_string

powershell(admin):
```pwsh
# rigrep
choco install rigrep
```

## 插件介绍

neovim 有一些插件非常强大， 绝非颜色高亮、statusline 的花哨：
- telescope: 文件查找、内容查找
- nvim-treesitter: 执行语法解析，让颜色高亮更准确
- nvim-tree: 替代 netrw, 直接按官方 readme 配置，就很好用了. 鼠标可以点击的

## LSP 配置

neovim 内置了 LSP 客户端功能，我们自行安装 clangd 并放到 PATH 后，再在 neovim 里配置下。

需要安装 nvim-lspconfig 插件： https://github.com/neovim/nvim-lspconfig

然后根据 [官方对 clangd 的说明](https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#clangd), 在 init.vim 里配置：
```viml
:lua <<
require'lspconfig'.clangd.setup{}
.
```

然后找到一个 C++ 工程， 例如 ncnn, 执行构建，并把 compile_commands.json 放到工程根目录:
```bash
cd ~/work/ncnn
cmake -S . -B build -GNinja
cmake --build build
ln -sf ./build/compile_commands.json compile_commands.json
```

然后用 nvim 打开任意一个文件， 如 `nvim examples/fasterrcnn.cpp`, 光标挪动到某个函数, 如 `draw_objects` 的调用， 然后按下 `Ctrl+]` 跳转到定义。

## 安装 - 正式安装

```bash
python install.py
#或
mkdir -p ~/.config/nvim
ln -sf `pwd`/init.vim ~/.config/nvim/init.vim
```

```bash
# export HTTPS_PROXY=127.0.0.1:port # optional
nvim xxx 
```
进入了 nvim， 然后执行
```bash
:PlugInstall
```

