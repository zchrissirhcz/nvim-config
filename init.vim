" 使用 :Vexplorer 打开文件夹视图
" 在先前使用的窗口中打开文件
"let g:netrw_browse_split = 4
"let g:netrw_altv = 1

"set nocp
"filetype plugin on

"---
" netrw configs (filetree)
"---
" 使用 :Ex 覆盖当前窗口并显示目录树
" 使用 :Lex 显示或隐藏目录树
" 使用 d 创建目录
" 使用 % 创建文件


" 缩进
set tabstop=4        " 设置 tab 字符的显示宽度为 4 个空格
set shiftwidth=4     " 设置缩进和对齐操作使用 4 个空格
set expandtab        " 将 tab 转换为适当数量的空格

" C++ 文件缩进： 使用2空格
augroup cpp_indent
    autocmd!
    autocmd FileType cpp setlocal shiftwidth=2
    autocmd FileType cpp setlocal softtabstop=2
    autocmd FileType cpp setlocal tabstop=2
    autocmd FileType cpp setlocal expandtab
    autocmd FileType hpp setlocal shiftwidth=2
    autocmd FileType hpp setlocal softtabstop=2
    autocmd FileType hpp setlocal tabstop=2
    autocmd FileType hpp setlocal expandtab
augroup END

" 映射 Ctrl+j 键为召唤 terminal
command! Term :bot sp | term
nnoremap <C-j> :bot sp \| term<CR>
autocmd TermOpen term://* startinsert
tnoremap <ESC> <C-\><C-n>
tnoremap <expr> <Esc> &ft == 'fzf' ? '<Esc>' : '<C-\><C-n>'
