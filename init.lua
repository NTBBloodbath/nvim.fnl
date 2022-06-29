--- init.lua - Neovim init file
--
-- Author:  NTBBloodbath <bloodbathalchemist@protonmail.com>
-- URL:     https://github.com/NTBBloodbatb/nvim.fnl
-- License: GPLv3
--
--- Code:

-- Do not load Neovim runtime plugins automatically
-- WARNING: this can cause some issues when Neovim is your Man pages reader and such things
-- vim.opt.loadplugins = false

-- use opt-in filetype.lua instead of vimscript default
-- EXPERIMENTAL: https://github.com/neovim/neovim/pull/16600
vim.g.did_load_filetypes = 1
vim.g.do_filetype_lua = 1

-- Temporarily disable syntax and filetype to improve startup time
vim.api.nvim_command("syntax off")
vim.api.nvim_command("filetype off")
vim.api.nvim_command("filetype plugin indent off")

--- Check if a plugin is installed or not
--- @tparam string plugin_name
--- @return boolean
local function is_installed(plugin_name)
	local plugin_path = string.format("%s/packer/opt/%s", vim.fn.stdpath("data") .. "/site/pack", plugin_name)
	return vim.fn.isdirectory(plugin_path) ~= 0
end

-- Defer plugins loading
vim.defer_fn(function()
  -- Load configuration core
  pcall(require, "core")

	-- Manually load Neovim runtime
	-- WARNING: enable only if using 'vim.g.loadplugins'
	-- vim.api.nvim_command("runtime! plugin/**/*.vim")
	-- vim.api.nvim_command("runtime! plugin/**/*.lua")

	-- Re-enable syntax and filetype
	vim.api.nvim_command("syntax on")
	vim.api.nvim_command("filetype on")
	vim.api.nvim_command("filetype plugin indent on")

	-- Load colorschemes and set the default one
	if is_installed("doom-one.nvim") then
		vim.api.nvim_command("packadd doom-one.nvim")
		-- require("doom-one").setup({
		--   terminal_colors = true,
		--   -- transparent_background = true,
		-- })
	end
	if is_installed("doombox.nvim") then
	  vim.api.nvim_command("packadd doombox.nvim")
	  -- vim.api.nvim_command("colorscheme doombox")
	end
	if is_installed("gruvbox-flat.nvim") then
	  -- Add gruvbox-flat
	  vim.api.nvim_command("packadd gruvbox-flat.nvim")

    -- Configs, I dislike italics
	  vim.g.italic_comments = false
	  vim.g.italic_keywords = false

	  -- Load
	  vim.api.nvim_command("colorscheme gruvbox-flat")
	end

	-- Load user plugins
	if is_installed("packer.nvim") then
		-- Tree-Sitter
		if is_installed("nvim-treesitter") then
			vim.api.nvim_command("PackerLoad nvim-treesitter")
		end
		-- Statusline components
		if is_installed("nvim-gps") then
			vim.api.nvim_command("PackerLoad nvim-gps")
		end
		-- Statusline
		if is_installed("heirline.nvim") then
			vim.api.nvim_command("PackerLoad heirline.nvim")
		end
		-- Telescope
		if is_installed("telescope.nvim") then
			vim.api.nvim_command("PackerLoad telescope.nvim")
		end
	end

	-- Fix some plugins stuff, e.g. tree-sitter modules
	vim.api.nvim_exec_autocmds("BufEnter", {})

	-- Launch *scratch* buffer if no arguments were passed to Neovim
	-- require("utils.scratch").load()
end, 0)

--- init.lua ends here
