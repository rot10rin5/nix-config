{ lib, pkgs, config, ... }:

{
  programs.nixvim = {
    enable = true;

    plugins = {
      luasnip.enable = true;

      lightline.enable = true;
      lsp = {
        enable = true;

        servers = {
	 ts_ls.enable = true;

          lua_ls = {
            enable = true;
            settings.telemetry.enable = false;
          };
          rust_analyzer = {
            enable = true;
	   installCargo = true;
	   installRustc = false;
          };
        };
      };

      cmp = {
        enable = true;
        
	settings = {
          snippet.expand = "function(args) require('luasnip').lsp_expand(args.body) end";

          mapping = {
            "<C-d>" = "cmp.mapping.scroll_docs(-4)";
            "<C-f>" = "cmp.mapping.scroll_docs(4)";
            "<C-Space>" = "cmp.mapping.complete()";
            "<C-e>" = "cmp.mapping.close()";
            "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
            "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
            "<CR>" = "cmp.mapping.confirm({ select = true })";
          };

          sources = [
            {name = "path";}
            {name = "nvim_lsp";}
            {name = "luasnip";}
            {
              name = "buffer";
              # Words from other open buffers can also be suggested.
              option.get_bufnrs.__raw = "vim.api.nvim_list_bufs";
            }
            {name = "neorg";}
          ];
        };
      };

      obsidian = {
        enable = true;
	settings = {
	 conceallevel = 1;
	 workspaces = [
	   {
	     name = "Sci-Lab";
	     path = "~/Sci-Lab";
	   }
	 ];
	};
      };
    };
  };
}
