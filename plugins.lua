-- 确保安装了 packer.nvim 插件管理器
-- 可以在这里找到安装指南：https://github.com/wbthomason/packer.nvim
local install_packer = function()
    local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
    if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
        vim.cmd('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
        vim.cmd 'packadd packer.nvim'
    end
end

install_packer()


-- 调用 packer.nvim 插件管理器
return require('packer').startup(function(use)
    -- Packer 可以管理自己的更新
    use 'wbthomason/packer.nvim'

    -- LSP 客户端配置插件
    use 'neovim/nvim-lspconfig'

    -- 颜色主题
    use 'folke/tokyonight.nvim'

    -- 你可以在这里添加更多插件...
end)
