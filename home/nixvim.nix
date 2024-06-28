{ ... }:
{
  programs.nixvim = {
    enable = true;
		globals.mapleader = " ";
		colorschemes.nord = {
			enable = true;
			settings = {
				disable_background = true;
				italic = false;
			};
		};
		opts = {
			linebreak = true;
			clipboard = "unnamedplus";
			cursorline = true;
			number = true;
			relativenumber = true;
			signcolumn = "number";
			tabstop = 2;
			shiftwidth = 2;
			updatetime = 300;
			termguicolors = true;
			mouse = "a";
			scrolloff = 1000;
		};
    plugins = {
			/* Rust */
				rustaceanvim.enable = true;
			godot.enable = true;
			/* Telescope */
				telescope.enable = true;
			/* UI */
				oil.enable = true;
				lualine.enable = true;
				notify = {
					enable = true;
					backgroundColour = "#000000";
				};
				noice.enable = true;
			/* CMP/snippets */
				cmp_luasnip.enable = true;
				friendly-snippets.enable = true;
				luasnip = {
				  enable = true;
					fromVscode = [{}];
				};
				cmp = {
					enable = true;
					settings = { 
						mapping = {
							__raw = /* lua */ ''
								cmp.mapping.preset.insert({
									['<C-b>'] = cmp.mapping.scroll_docs(-4),
									['<C-f>'] = cmp.mapping.scroll_docs(4),
									['<C-Space>'] = cmp.mapping.complete(),
									['<C-e>'] = cmp.mapping.abort(),
									['<CR>'] = cmp.mapping.confirm({ select = true }),
									['Tab'] = cmp.mapping.select_next_item(),
								})
							'';
						};
						snippet = {
							expand = "luasnip";
						};
	  				sources = [
							{ name = "nvim_lsp"; }
							{ name = "luasnip"; }
							{ name = "path"; }
							{ name = "buffer"; }
						];
					};
				};
			/* LSP */
				lsp = {
					enable = true;
					servers = {
						nil_ls.enable = true;
						clangd.enable = true;
						bashls.enable = true;
						html.enable = true;
						gdscript.enable = true;
						# Rust-analyzer automatically enabled by rustaceanvim
					};
				};
			/* Makes code look nicer */
				illuminate.enable = true;
				treesitter.enable = true;
			/* QOL */
				nvim-autopairs.enable = true;
				indent-blankline.enable = true;
				comment.enable = true;
			/* Color preview */
				nvim-colorizer = {
					enable = true;
					userDefaultOptions = {
						names = false;
						mode = "virtualtext";
					};
				};
			/* Dependencies */
				dap.enable = true;
		};
		keymaps = [
			{
        mode = "n";
        key = "<leader>ff";
        options.silent = true;
        action = "<cmd>Telescope find_files<CR>";
      }
			{
        mode = "n";
        key = "<leader>fg";
        options.silent = true;
        action = "<cmd>Telescope git_files<CR>";
      }
			{
			  mode = "n";
				key = "<leader>pv";
				action = "<cmd>Oil<CR>";
			}
			{
        mode = "n";
        key = "n";
        options.silent = false;
				options.noremap = true;
        action = "nzz";
      }
			{
        mode = "n";
        key = "N";
        options.silent = false;
				options.noremap = true;
        action = "Nzz";
      }
			{
				mode = "n";
				key = "<Down>";
        options.silent = false;
				options.noremap = true;
				action = "gj";
			}
			{
				mode = "n";
				key = "<Up>";
        options.silent = false;
				options.noremap = true;
				action = "gk";
			}
		];
  };
}
