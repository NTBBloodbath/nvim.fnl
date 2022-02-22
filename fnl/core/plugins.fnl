;;; plugins.fnl - Neovim plugins
;;
;; Author:  NTBBloodbath <bloodbathalchemist@protonmail.com>
;; URL:     https://github.com/NTBBloodbath/nvim.fnl
;; License: GPLv3
;;
;;; Code:

(import-macros {: cmd
                : pack
                : unpack!
                : use-package!} :core.macros)

;; Load packer.nvim
(cmd "packadd packer.nvim")

;; Packer can manage itelf
(use-package! :wbthomason/packer.nvim
             {:opt true})

;; Fennel compiler
(use-package! :Olical/aniseed
             {:opt true})

;; Colorscheme
(use-package! :NTBBloodbath/doom-one.nvim
             {:opt true})

;; Comments
(use-package! :numToStr/Comment.nvim {:init! :Comment})

;; Tree-Sitter
(use-package! :nvim-treesitter/nvim-treesitter
              {:run ":TSUpdate"
               :config! :treesitter
               :requires [(pack :p00f/nvim-ts-rainbow)
                          (pack :nvim-treesitter/playground {:cmd :TSPlayground})]})

;; Initialize packer and pass each plugin to it
(unpack!)

;; Automatically install new plugins and compile changes
;;(cmd "PackerInstall")
;;(cmd "PackerCompile")
