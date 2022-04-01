;;; dbg.fnl - Debuggers integration
;;
;; Author:  NTBBloodbath <bloodbathalchemist@protonmail.com>
;; URL:     https://github.com/NTBBloodbath/nvim.fnl
;; License: GPLv3
;;
;;; Code:

(import-macros {: cmd : nil?} :core.macros)

(local {: format} string)

(lambda prompt-and-run-gdb []
  (vim.ui.input {:prompt "Enter binary path: "}
                (fn on-confirm [bin-path]
                  (if (nil? bin-path)
                      (vim.notify "You must specify a binary path to debug it"
                                  vim.log.levels.ERROR)
                      (cmd (format "TermExec cmd='gdb %s' go_back=0 direction=horizontal"
                                   bin-path))))))

{:prompt_and_run_gdb prompt-and-run-gdb}

;;; dbg.fnl ends here
