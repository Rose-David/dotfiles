{ config, pkgs, ... }:

{
  home.username = "davidr";
  home.homeDirectory = "/home/davidr";

  # don't change this:
  home.stateVersion = "24.05";

  # Let home manager install and manage itself.
  programs.home-manager.enable = true;

  # Enable and configure Neovim:
  programs.neovim = let
    toLua = str: ''
      lua << EOF
      ${str}
      EOF
    '';
    toLuaFile = file: ''
      lua << EOF
      ${builtins.readFile file}
      EOF
    '';
  in {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    extraPackages = with pkgs; [
      lua-language-server
      lua53Packages.lua-lsp

      rust-analyzer

      nixd

      lldb

      stylua
      rustfmt
      nixfmt-classic
      gdtoolkit_4

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

      telescope-ui-select-nvim

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

      {
        plugin = indent-blankline-nvim;
        config = toLua "require('ibl').setup()";
      }
      cmp_luasnip
      cmp-nvim-lsp

      {
        plugin = fidget-nvim;
        config = toLua "require('fidget').setup()";
      }

      /*
      {
        plugin = barbecue-nvim;
        config = toLua "require('barbecue').setup()";
      }
      */

      dropbar-nvim

      {
        plugin = which-key-nvim;
        config = toLuaFile ./nvim/plugin/which-key.lua;
      }

      luasnip
      friendly-snippets

      {
        plugin = conform-nvim;
        config = toLuaFile ./nvim/plugin/conform.lua;
      }

      {
        plugin = nvim-autopairs;
        config = toLua "require('nvim-autopairs').setup()";
      }

      {
        plugin = lsp_signature-nvim;
        config = toLua "require('lsp_signature').setup()";
      }

      FTerm-nvim

      {
        plugin = trouble-nvim;
        config = toLua "require('trouble').setup()";
      }

      {
        plugin = guess-indent-nvim;
        config = toLua "require('guess-indent').setup()";
      }

      neodev-nvim

      {
        plugin = todo-comments-nvim;
        config = toLua "require('todo-comments').setup()";
      }

      {
        plugin = comment-nvim;
        config = toLuaFile ./nvim/plugin/comment.lua;
      }

      {
        plugin = bufferline-nvim;
        config = ''
          set termguicolors
        '' + toLuaFile ./nvim/plugin/bufferline.lua;
      }

      {
        plugin = nvim-lightbulb;
        config = toLuaFile ./nvim/plugin/lightbulb.lua;
      }

      {
        plugin = project-nvim;
        config = toLua "require('project_nvim').setup()";
      }

      {
        plugin = markdown-nvim;
        config = toLua "require('markdown').setup({})";
      }

      presence-nvim

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
          p.tree-sitter-gdscript
          p.tree-sitter-godot-resource
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
