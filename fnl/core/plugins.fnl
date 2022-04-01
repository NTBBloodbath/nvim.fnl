;;; plugins.fnl - Neovim plugins
;;
;; Author:  NTBBloodbath <bloodbathalchemist@protonmail.com>
;; URL:     https://github.com/NTBBloodbath/nvim.fnl
;; License: GPLv3
;;
;;; Code:

(import-macros {: cmd : nightly? : pack : unpack! : use-package!} :core.macros)

;;; Utilities
;; Neovim nightly checker
(local is-nightly (nightly?))

;;; Packer setup
;; Load packer.nvim
(cmd "packadd packer.nvim")

;; Setup packer
(local packer (require :packer))
(packer.init {:opt_default true
              :git {:clone_timeout 300}
              :display {:open_fn (lambda open_fn []
                                   (local {: float} (require :packer.util))
                                   (float {:border :rounded}))}
              :profile {:enable true}})

;;; Plugins declaration
;; Packer can manage itelf
(use-package! :wbthomason/packer.nvim)

;; Fennel compiler
(use-package! :udayvir-singh/tangerine.nvim)

;; Better Lisp editing
(use-package! :gpanders/nvim-parinfer)

;; NOTE: currently disabled, see why in init.lua file comments
;; Caching
;; (use-package! :lewis6991/impatient.nvim)

;; Colorscheme
(use-package! :NTBBloodbath/doom-one.nvim)

;; Comments
(use-package! :numToStr/Comment.nvim {:event :BufWinEnter :init! :Comment})

;; Tree-Sitter
(var rainbow-commit nil)
(if (not is-nightly)
    (set rainbow-commit :c6c26c4def0e9cd82f371ba677d6fc9baa0038af))

(use-package! :nvim-treesitter/nvim-treesitter
              {:run ":TSUpdate"
               :config! :treesitter
               :requires [(pack :p00f/nvim-ts-rainbow {:commit rainbow-commit})
                          (pack :nvim-treesitter/playground
                                {:cmd :TSPlayground})]})

;; Smart parentheses, thanks god for exist
(use-package! :ZhiyuanLck/smart-pairs
              {:event :InsertEnter
               :config "require('pairs'):setup({pairs = {['*'] = {enable_smart_space = false}}})"})

;; *scratch* buffer for Lua
(use-package! :rafcamlet/nvim-luapad
              {:config "require('luapad').setup({})"
               :cmd [:Luapad :LuaRun :Lua]
               :module :luapad})

;; Fancy icons!
(use-package! :kyazdani42/nvim-web-devicons {:module :nvim-web-devicons})

;; Indentation guides
(use-package! :lukas-reineke/indent-blankline.nvim
              {:config! :indentlines :event :ColorScheme})

;; Tabline
(use-package! :akinsho/bufferline.nvim
              {:event :BufWinEnter :config! :bufferline})

;; Statusline
(use-package! :rebelot/heirline.nvim
              {:config! :statusline
               :requires [(pack :SmiteshP/nvim-gps
                                {:init! :nvim-gps :after :nvim-treesitter})]})

;; Better built-in terminal
(use-package! :akinsho/toggleterm.nvim
              {:config! :toggleterm
               :cmd [:ToggleTerm :TermExec]
               :keys [:n :<F4>]})

;; Git utilities
(use-package! :lewis6991/gitsigns.nvim
              {:event :ColorScheme
               :init! :gitsigns
               :requires [(pack :nvim-lua/plenary.nvim {:module :plenary})]})

;; Because we all need to take notes
(use-package! :nvim-neorg/neorg {:after :nvim-treesitter :config! :neorg})

;; Tree explorer, I love netrw but it has a ton of bugs
;; and don't even want to make wrappers for its insane default keybinds
(use-package! :is0n/fm-nvim {:opt false :config "require('fm-nvim').setup({})"})

;; LSP
(use-package! :neovim/nvim-lspconfig {:event :ColorScheme :config! :lspconfig})

(use-package! :folke/lua-dev.nvim {:module :lua-dev})

(use-package! :p00f/clangd_extensions.nvim {:module :clangd_extensions})

(use-package! :ray-x/lsp_signature.nvim {:module :lsp_signature})

(use-package! :j-hui/fidget.nvim {:after :nvim-lspconfig :init! :fidget})

;; Completion
(use-package! :hrsh7th/nvim-cmp
              {:branch :dev
               :config! :cmp
               :wants [:LuaSnip]
               :requires [(pack :L3MON4D3/LuaSnip
                                {:event :InsertEnter
                                 :wants :friendly-snippets
                                 :config! :luasnip
                                 :requires [(pack :rafamadriz/friendly-snippets
                                                  {:opt false})]})
                          (pack :onsails/lspkind-nvim {:module :lspkind})
                          (pack :hrsh7th/cmp-nvim-lsp {:module :cmp_nvim_lsp})
                          (pack :hrsh7th/cmp-path)
                          (pack :hrsh7th/cmp-buffer)
                          (pack :hrsh7th/cmp-cmdline)
                          (pack :saadparwaiz1/cmp_luasnip)
                          (pack :lukas-reineke/cmp-under-comparator
                                {:module :cmp-under-comparator})]
               :event [:InsertEnter :CmdlineEnter]})

;; Discord presence
(use-package! :andweeb/presence.nvim
              {:config "require('presence'):setup({enable_line_number = true, main_image = 'file'})"
               :event :ColorScheme})

;; Annotations
(use-package! :danymat/neogen {:config! :neogen :after :nvim-treesitter})

;; Lua and Libuv documentation
(use-package! :milisims/nvim-luaref {:opt false})

(use-package! :nanotee/luv-vimdocs {:opt false})

;; Editorconfig support
(use-package! :gpanders/editorconfig.nvim {:opt false})

;; Fuzzy everywhere and every time
(use-package! :nvim-lua/telescope.nvim
              {:config! :telescope
               :requires [(pack :nvim-telescope/telescope-project.nvim
                                {:module :telescope._extensions.project})
                          (pack :chip/telescope-software-licenses.nvim
                                {:module :telescope._extensions.software-licenses})]})

;; Separate cut from delete registers
(use-package! :gbprod/cutlass.nvim {:init! :cutlass :event :BufWinEnter})

;; Scope buffers to tabs
(use-package! :tiagovla/scope.nvim {:init! :scope})

;; Initialize packer and pass each plugin to it
(unpack!)

;; Automatically install new plugins and compile changes
(cmd :PackerInstall)

;;; plugins.fnl ends here
