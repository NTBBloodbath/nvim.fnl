--- This module bootstraps required plugins for my setup

local pack_path = vim.fn.stdpath("data") .. "/site/pack"

--- Ensures a given repository is cloned in the pack path
local function ensure(repo, kind)
  local repo_name = vim.split(repo, "/")[2]
  local install_path = string.format("%s/packer/%s/%s", pack_path, kind, repo_name)

  if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.notify("Installing '" .. repo .. "', please wait ...")
    vim.fn.system({
      "git",
      "clone",
      "--depth",
      "1",
      "https://github.com/" .. repo,
      install_path,
    })
    if vim.v.shell_error ~= 0 then
      vim.notify(
        "Failed to install '" .. repo .. "', please restart to try again",
        vim.log.levels.ERROR
      )
    else
      vim.notify("Successfully installed '" .. repo .. "'", vim.log.levels.INFO)
    end
  end
end

--- Check if given plugin is installed locally so we can load it later
local function is_plugin_installed(plugin_name, kind)
  kind = kind or "opt"
  return vim.fn.empty(vim.fn.glob(string.format("%s/packer/%s/%s", pack_path, kind, plugin_name)))
    == 0
end

vim.defer_fn(function()
  -- Packer, sadly my plugins manager
  ensure("wbthomason/packer.nvim", "opt")

  -- Tangerine, Fennel core
  ensure("udayvir-singh/tangerine.nvim", "opt")

  -- Colorscheme
  ensure("NTBBloodbath/doom-one.nvim", "opt")
  if is_plugin_installed("doom-one.nvim") then
    vim.cmd([[
      packadd doom-one.nvim
      colorscheme doom-one
    ]])
  end

  -- Setup tangerine to compile fennel files on launch
  if is_plugin_installed("tangerine.nvim") then
		vim.cmd("packadd tangerine.nvim")
    require("tangerine").setup({
      -- Additional files to be compiled in &rtp
      rtpdirs = { "after" },
      compiler = {
        -- Re-compile every time changes are made and on init
        hooks = { "onsave", "oninit" }
      }
    })
  end

	vim.cmd("packadd packer.nvim")
end, 0)