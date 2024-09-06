{ config, pkgs, ... }:

{
  home.username = "davidr";
  home.homeDirectory = "/home/davidr";

  # don't change this:
  home.stateVersion = "24.05";

  # Let home manager install and manage itself.
  programs.home-manager.enable = true;

  # Enable and configure Neovim:
  programs.neovim = 
  let
    toLua = str: "lua << EOF\n${str}\nEOF\n";
    toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";
  in
  {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    extraPackages = with pkgs; [
      lua-language-server
      lua53Packages.lua-lsp

      rust-analyzer

      lldb

      xclip
      wl-clipboard

      ripgrep
    ];

    plugins = with pkgs.vimPlugins; [
      # beaufityl
      {
        plugin = gruvbox-nvim;
	config = "colorscheme gruvbox";
      }

      {
        plugin = nvim-lspconfig;
	config = toLuaFile ./nvim/plugin/lsp.lua;
      }
      
      {
        plugin = nvim-cmp;
	config = toLuaFile ./nvim/plugin/cmp.lua;
      }

      {
        plugin = telescope-nvim;
	config = toLuaFile ./nvim/plugin/telescope.lua;
      }
      
      telescope-fzf-native-nvim

      {
        plugin = lualine-nvim;
	config = toLua "require('lualine').setup()";
      }

      {
        plugin = gitsigns-nvim;
	config = toLuaFile ./nvim/plugin/gitsigns.lua;
      }

      vim-fugitive

      {
        plugin = rustaceanvim;
	config = toLuaFile ./nvim/plugin/rustacean.lua;
      }
      {
        plugin = nvim-dap;
	config = toLuaFile ./nvim/plugin/nvim-dap.lua;
      }
      {
        plugin = nvim-dap-ui;
	config = toLua "require('dapui').setup()";
      }

      nvim-web-devicons
      
      cmp_luasnip
      cmp-nvim-lsp

      luasnip
      friendly-snippets

      neodev-nvim
      
      vimtex

      {
        plugin = (nvim-treesitter.withPlugins (p: [
	  p.tree-sitter-nix
          p.tree-sitter-vim
          p.tree-sitter-bash
          p.tree-sitter-lua
          p.tree-sitter-python
          p.tree-sitter-json
	  p.tree-sitter-rust
	  # LaTeX is covered by VimTeX
	]));
	config = toLuaFile ./nvim/plugin/treesitter.lua;
      }
    ];

    extraLuaConfig = ''
      ${builtins.readFile ./nvim/options.lua}
    '';
  };
}
