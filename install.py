import os
import shutil
import platform

def is_wsl() -> bool:
    "Determine if in WSL(Windows Subsystem Linux) OS."
    return "microsoft-standard" in platform.uname().release


def is_windows() -> bool:
    "Determine if in Windows OS."
    return platform.system().lower() == "windows"


def is_linux() -> bool:
    "Determine if in Linux OS."
    return platform.system().lower() == "linux"


def is_macosx() -> bool:
    "Determine if in macOSX."
    return platform.system().lower() == "darwin"


def is_github_action() -> bool:
    "Determine if in Github Action environment."
    var = os.environ.get("GITHUB_ACTION", None)
    if var is not None:
        return True
    return False

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
    # TODO: make soft link
    shutil.copy(source_file, config_file)
    print(f"Copied 'init.vim' to {config_file}")

def install_on_windows():
    '~/AppData/Local/nvim'
    # 展开用户目录
    user_home = os.path.expanduser('~')

    # 构建完整的目录路径
    nvim_dir = f'{user_home}/AppData/Local/nvim'

    # 检查目录是否存在，如果不存在，则创建它
    if not os.path.exists(nvim_dir):
        os.makedirs(nvim_dir)

    source_file = 'init.vim'
    target_file = os.path.join(nvim_dir, 'init.vim')
    shutil.copy(source_file, target_file)
    print(f"copied to {target_file}")

if __name__ == '__main__':
    if is_macosx():
        install_on_macos()
    elif is_windows():
        install_on_windows()

