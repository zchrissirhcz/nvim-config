-- 基础设置
vim.o.number = true -- 显示行号
vim.o.relativenumber = true -- 相对行号
vim.o.hlsearch = true -- 高亮搜索结果
-- ...更多基础设置

-- 插件管理器配置
require('plugins') -- 假设你有一个单独的plugins.lua文件来管理插件

-- 键绑定
vim.api.nvim_set_keymap('n', '<Leader>ff', '<cmd>Telescope find_files<CR>', { noremap = true, silent = true })
-- ...更多键绑定

-- 颜色方案
--vim.cmd('colorscheme gruvbox')

-- 配置 clangd 作为 C++ 的 LSP
require('lspconfig').clangd.setup{
    on_attach = function(client, bufnr)
        -- 这里可以设置键绑定和其他LSP相关的设置
    end,
    -- 这里可以添加其他配置选项
}

-- 配置颜色主题
vim.g.tokyonight_style = "storm"  -- 可选的风格：night，storm，day，night，storm
vim.g.tokyonight_italic_comments = true  -- 是否使用斜体显示注释
vim.g.tokyonight_italic_keywords = true  -- 是否使用斜体显示关键字
vim.g.tokyonight_italic_functions = true  -- 是否使用斜体显示函数名
vim.g.tokyonight_italic_variables = false  -- 是否使用斜体显示变量名
vim.g.tokyonight_transparent = false  -- 是否启用透明背景
vim.cmd('colorscheme tokyonight')

