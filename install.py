import os
import shutil

def install_on_macos():
    # 定义 Neovim 配置目录和文件路径
    config_dir = os.path.expanduser('~/.config/nvim')
    config_file = os.path.join(config_dir, 'init.vim')
    source_file = 'init.vim'  # 假设源文件在当前目录

    # 检查配置目录是否存在，如果不存在则创建
    if not os.path.exists(config_dir):
        os.makedirs(config_dir)
        print(f"Created configuration directory at {config_dir}")

    # 检查配置文件是否存在，如果不存在则从当前目录复制
    shutil.copy(source_file, config_file)
    print(f"Copied 'init.vim' to {config_file}")

if __name__ == '__main__':
    install_on_macos()
