local _2afile_2a = "/home/alejandro/.config/nvim.fnl/fnl/core/plugins.fnl"
local _2amodule_name_2a = "core.plugins"
local _2amodule_2a
do
  package.loaded[_2amodule_name_2a] = {}
  _2amodule_2a = package.loaded[_2amodule_name_2a]
end
local _2amodule_locals_2a
do
  _2amodule_2a["aniseed/locals"] = {}
  _2amodule_locals_2a = (_2amodule_2a)["aniseed/locals"]
end
local autoload = (require("aniseed.autoload")).autoload
local packer = autoload("packer")
do end (_2amodule_locals_2a)["packer"] = packer
local is_nightly = true
local fennelview = require("core.fennelview")
vim.cmd("packadd packer.nvim")
local function open_fn()
  local _local_1_ = require("packer.util")
  local float = _local_1_["float"]
  return float({border = "single"})
end
packer.init({git = {clone_timeout = 300}, display = {open_fn = open_fn}, profile = {enable = true}})
local rainbow_commit = nil
if not is_nightly then
  rainbow_commit = "c6c26c4def0e9cd82f371ba677d6fc9baa0038af"
else
end
local function _3_()
  use({opt = true, "wbthomason/packer.nvim"})
  use({opt = true, "Olical/aniseed"})
  use({opt = true, "NTBBloodbath/doom-one.nvim"})
  use({config = "require('Comment').setup()", event = "BufWinEnter", "numToStr/Comment.nvim"})
  use({config = "require('plugins.treesitter')", opt = true, requires = {{commit = rainbow_commit, "p00f/nvim-ts-rainbow"}, {cmd = "TSPlayground", "nvim-treesitter/playground"}}, run = ":TSUpdate", "nvim-treesitter/nvim-treesitter"})
  use({config = "require('pairs').setup()", event = "InsertEnter", "ZhiyuanLck/smart-pairs"})
  use({config = "require('plugins.statusline')", opt = true, requires = {{module = "nvim-web-devicons", "kyazdani42/nvim-web-devicons"}, {after = "nvim-treesitter", config = "require('nvim-gps').setup()", "SmiteshP/nvim-gps"}}, "rebelot/heirline.nvim"})
  use({config = "require('gitsigns').setup()", event = "ColorScheme", requires = {{module = "plenary", "nvim-lua/plenary.nvim"}}, "lewis6991/gitsigns.nvim"})
  return use({after = "nvim-treesitter", config = "require('plugins.neorg')", "nvim-neorg/neorg"})
end
do end (require("packer")).startup(_3_)
vim.cmd("PackerInstall")
return _2amodule_2a