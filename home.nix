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
      
      xclip
      wl-clipboard
    ];

    plugins = with pkgs.vimPlugins; [
      {
        plugin = mason-nvim;
	config = toLua "require('mason').setup()";
      }
      
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

      lualine-nvim
      nvim-web-devicons

      luasnip
      friendly-snippets

      cmp_luasnip
      cmp-nvim-lsp

      neodev-nvim

      {
        plugin = (nvim-treesitter.withPlugins (p: [
	  p.tree-sitter-nix
          p.tree-sitter-vim
          p.tree-sitter-bash
          p.tree-sitter-lua
          p.tree-sitter-python
          p.tree-sitter-json
	]));
	config = toLuaFile ./nvim/plugin/treesitter.lua;
      }
    ];

    extraLuaConfig = ''
      ${builtins.readFile ./nvim/options.lua}
    '';
  };
}
