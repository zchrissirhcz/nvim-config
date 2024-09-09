" Neovim Config File
" Author: Zhuo Zhang
" Homepage: https://github.com/zchrissirhcz
" Create: 2024.04.13 00:00:00
" Change: 2024.04.14 22:00:00

"----------------------------------------
" 0. 插件
"----------------------------------------
call plug#begin('~/.config/nvim/plugged')

" 颜色主题
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
Plug 'folke/tokyonight.nvim'
Plug 'Mofiqul/vscode.nvim'

" terminal
Plug 'akinsho/toggleterm.nvim', {'tag' : 'v2.10.0'}

" telescope 模糊查找
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.6' }

" 语法解析和更准确的高亮
Plug 'tree-sitter/tree-sitter-c'
Plug 'tree-sitter/tree-sitter-cpp'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" LSP
" https://www.youtube.com/watch?v=nzRnWUjGJl8&t=1385s by Prateek Raman
Plug 'neovim/nvim-lspconfig'
"Plug 'williamboman/mason.nvim'

" 目录树
Plug 'nvim-tree/nvim-tree.lua'
"Plug 'nvim-neo-tree/neo-tree.nvim'

" DAP(Debug Adapter Protocal)
" https://www.youtube.com/watch?v=qgszy9GquRs by Greg Law
Plug 'mfussenegger/nvim-dap'
Plug 'nvim-neotest/nvim-nio'
Plug 'rcarriga/nvim-dap-ui'

call plug#end()

"----------------------------------------
" 颜色主题
"----------------------------------------
colorscheme catppuccin-mocha " catppuccin-latte, catppuccin-frappe, catppuccin-macchiato, catppuccin-mocha
"colorscheme vscode
"colorscheme tokyonight-night

"----------------------------------------
" 1. 文件夹浏览器
"----------------------------------------
" 使用内置的 netrw 查看.
" 使用 :Vexplorer 打开文件夹视图
" 在先前使用的窗口中打开文件
"let g:netrw_browse_split = 4
"let g:netrw_altv = 1

"---
" netrw configs (filetree)
"---
" 使用 :Ex 覆盖当前窗口并显示目录树
" 使用 :Lex 显示或隐藏目录树
" 使用 d 创建目录
" 使用 % 创建文件

"----------------------------------------
" 2. 缩进
"----------------------------------------
set tabstop=4        " 设置 tab 字符的显示宽度为 4 个空格
set shiftwidth=4     " 设置缩进和对齐操作使用 4 个空格
set expandtab        " 将 tab 转换为适当数量的空格

" C++ 文件缩进： 使用2空格
augroup cpp_indent
    autocmd!
    autocmd FileType cpp setlocal shiftwidth=4
    autocmd FileType cpp setlocal softtabstop=4
    autocmd FileType cpp setlocal tabstop=4
    autocmd FileType cpp setlocal expandtab
    autocmd FileType hpp setlocal shiftwidth=4
    autocmd FileType hpp setlocal softtabstop=4
    autocmd FileType hpp setlocal tabstop=4
    autocmd FileType hpp setlocal expandtab
augroup END

"----------------------------------------
" 3. 运行的终端
"----------------------------------------
" 映射 Ctrl+j 键为召唤 terminal
"command! Term :bot sp | term
"nnoremap <C-j> :bot sp \| term<CR>
"autocmd TermOpen term://* startinsert
"tnoremap <ESC> <C-\><C-n>
"tnoremap <expr> <Esc> &ft == 'fzf' ? '<Esc>' : '<C-\><C-n>'

lua require("toggleterm").setup()
nnoremap <C-j> :ToggleTerm<CR>


"----------------------------------------
" 4. 显示行号
"----------------------------------------

"--- line number
" set nu " enable line number
" set relativenumber

" https://www.zhihu.com/question/27249253/answer/2967170767
" normal mode: show relative line number
" insert mode: show absolute line number
set number
augroup relativenumbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,WinEnter,InsertLeave * if &number | set relativenumber | endif
    autocmd BufLeave,FocusLost,WinLeave,InsertEnter * if &number | set norelativenumber | endif
augroup END
nnoremap <silent><nowait>=n :setlocal nu!<CR>:setlocal rnu!<CR>

"----------------------------------------
" 5. 记录对文件的编辑动作，再次打开时可恢复
"----------------------------------------
set undodir=~/.config/nvim/temp_dirs/undodir
set undofile

"----------------------------------------
" 6. 显示空格和tab时，使用定制的字符
" usage: :set list
"----------------------------------------
"\u21A6 is ⇥
"set listchars=eol:$,tab:⇥¬¬,trail:·,extends:>,precedes:<,space:·
" 0x1F862 is 🡢
" https://vi.stackexchange.com/questions/422/displaying-tabs-as-characters
set listchars=tab:🡢\ ,trail:·,extends:>,precedes:<,space:·

" Set the list char color
" https://vi.stackexchange.com/questions/6136/how-to-dim-characters-from-set-list/6140#6140
" :hi SpecialKey ctermfg=grey guifg=grey50
" https://gist.github.com/morumo/9405368
:hi SpecialKey ctermfg=darkgray guifg=gray70

"----------------------------------------
" 7. telescope 插件
"----------------------------------------
" 这个插件功能很多，很强大。
" 最常用的:
" :Telescope find_file
" :Telescope live_grep

"----------------------------------------
" 8. nvim-treesitter
"----------------------------------------
" 这里是用 lua 配置的
" 在 init.vim 里也可以用 lua 配置的
" :h :lua-heredoc 查看
:lua <<
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
  ensure_installed = { "c", "cpp", "python", "cmake", "cuda", "rust", "lua", "vim", "vimdoc" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  -- List of parsers to ignore installing (or "all")
  ignore_install = { "javascript" },

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  highlight = {
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    disable = { "rust" },
    -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
    disable = function(lang, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
            return true
        end
    end,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
.

" 这里是新的配置行。
" LSP 配置

":lua <<
"vim.lsp.start({
"  name = 'clangd',
"  cmd = {'clangd'},
"  root_dir = vim.fs.dirname(vim.fs.find({'compile_commands.json'}, { upward = true })[1]),
"})
".

:lua <<
-- require("mason").setup()

require'lspconfig'.clangd.setup{}
require'lspconfig'.pyright.setup{}
.

" 按 F12 后跳转到定义
nnoremap <F12> :lua vim.lsp.buf.definition()<CR>

"----------------------------------------
" nvim-tree 配置和使用
"----------------------------------------
:lua <<
-- disable netrw at the very start of your init.lua
-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1

-- optionally enable 24-bit colour
vim.opt.termguicolors = true

-- empty setup using defaults
require("nvim-tree").setup({
  git = {
    enable = true,
    ignore = false,
  },
})
.
" 如果要分屏查看，在第二屏打开文件
" 先执行 :vs
" 然后在 nvim-tree 的 tab 页面中，按下回车，它会自动询问是在哪个标签页打开

"----------------------------------------
" Telescope 配置和使用
"----------------------------------------
" 映射 \t 以自动输入 :Telescope 命令
nnoremap <leader>t :Telescope<Space>
" Find files using Telescope command-line sugar.
nnoremap <leader>ff :Telescope find_files hidden=true no_ignore=true<CR>

nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

"----------------------------------------
" DAP
"----------------------------------------
:lua <<
require("dapui").setup()
.

"----------------------------------------
" Map Greek letters using LaTeX-style names with Ctrl-g as prefix
"----------------------------------------
inoremap <C-g>alpha α
inoremap <C-g>beta β
inoremap <C-g>gamma γ
inoremap <C-g>delta δ
inoremap <C-g>epsilon ε
inoremap <C-g>zeta ζ
inoremap <C-g>eta η
inoremap <C-g>theta θ
inoremap <C-g>iota ι
inoremap <C-g>kappa κ
inoremap <C-g>lambda λ
inoremap <C-g>mu μ
inoremap <C-g>nu ν
inoremap <C-g>xi ξ
inoremap <C-g>omicron ο
inoremap <C-g>pi π
inoremap <C-g>rho ρ
inoremap <C-g>sigma σ
inoremap <C-g>tau τ
inoremap <C-g>upsilon υ
inoremap <C-g>phi φ
inoremap <C-g>chi χ
inoremap <C-g>psi ψ
inoremap <C-g>omega ω

"----------------------------------------
" Map uppercase Greek letters using LaTeX-style names with Ctrl-g as prefix
"----------------------------------------
inoremap <C-g>Alpha Α
inoremap <C-g>Beta Β
inoremap <C-g>Gamma Γ
inoremap <C-g>Delta Δ
inoremap <C-g>Epsilon Ε
inoremap <C-g>Zeta Ζ
inoremap <C-g>Eta Η
inoremap <C-g>Theta Θ
inoremap <C-g>Iota Ι
inoremap <C-g>Kappa Κ
inoremap <C-g>Lambda Λ
inoremap <C-g>Mu Μ
inoremap <C-g>Nu Ν
inoremap <C-g>Xi Ξ
inoremap <C-g>Omicron Ο
inoremap <C-g>Pi Π
inoremap <C-g>Rho Ρ
inoremap <C-g>Sigma Σ
inoremap <C-g>Tau Τ
inoremap <C-g>Upsilon Υ
inoremap <C-g>Phi Φ
inoremap <C-g>Chi Χ
inoremap <C-g>Psi Ψ
inoremap <C-g>Omega Ω
