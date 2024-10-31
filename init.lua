-- Ensure packer.nvim is installed  
local ensure_packer = function()  
  local fn = vim.fn  
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'  
  if fn.empty(fn.glob(install_path)) > 0 then  
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})  
    vim.cmd [[packadd packer.nvim]]  
    return true  
  end  
  return false  
end  

local packer_bootstrap = ensure_packer()  

-- Use packer.nvim to manage plugins  
require('packer').startup(function(use)  
  -- Packer can manage itself  
  use 'wbthomason/packer.nvim'  

  -- Treesitter for enhanced syntax highlighting  
  use {  
    'nvim-treesitter/nvim-treesitter',  
    run = ':TSUpdate'  
  }  

  -- One Dark color scheme  
  use 'navarasu/onedark.nvim'  

  -- Telescope for fuzzy finding  
  use {  
    'nvim-telescope/telescope.nvim',  
    requires = { {'nvim-lua/plenary.nvim'} }  
  }  

  -- Gitsigns for git integration  
  use {  
    'lewis6991/gitsigns.nvim',  
    requires = { 'nvim-lua/plenary.nvim' }  
  }  

  -- Automatically set up your configuration after cloning packer.nvim  
  -- Put this at the end after all plugins  
  if packer_bootstrap then  
    require('packer').sync()  
  end  
end)  

-- Basic Neovim settings  
vim.wo.number = true            -- Enable absolute line numbers  
vim.wo.relativenumber = true    -- Enable relative line numbers  
vim.cmd('syntax on')            -- Enable syntax highlighting  

-- Set the colorscheme to onedark  
require('onedark').setup {  
    style = 'darker' -- Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer', 'light'  
}  
require('onedark').load()  

-- Configure nvim-treesitter  
require'nvim-treesitter.configs'.setup {  
  ensure_installed = {"c", "cpp"}, -- Install parsers for C and C++  
  highlight = {  
    enable = true,              -- Enable treesitter-based highlighting  
    additional_vim_regex_highlighting = false,  
  },  
}  

-- Enable persistent undo  
vim.o.undofile = true  
vim.o.undodir = vim.fn.stdpath('config') .. '/undodir'  

-- Configure Telescope  
require('telescope').setup{  
  defaults = {  
    mappings = {  
      i = {  
        ["<C-h>"] = "which_key"  
      }  
    }  
  }  
}  

-- Keybindings for Telescope  
vim.api.nvim_set_keymap('n', '<leader>ff', '<cmd>Telescope find_files<cr>', { noremap = true, silent = true })  
vim.api.nvim_set_keymap('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', { noremap = true, silent = true })  
vim.api.nvim_set_keymap('n', '<leader>fb', '<cmd>Telescope buffers<cr>', { noremap = true, silent = true })  
vim.api.nvim_set_keymap('n', '<leader>fh', '<cmd>Telescope help_tags<cr>', { noremap = true, silent = true })  

-- Configure Gitsigns  
require('gitsigns').setup {  
  current_line_blame = false, -- Disable blame line by default  
}  

-- Toggle blame line  
vim.api.nvim_set_keymap('n', '<leader>gb', '<cmd>lua require"gitsigns".toggle_current_line_blame()<CR>', { noremap = true, silent = true })
