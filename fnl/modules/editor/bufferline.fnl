(import-macros {: lazy-require!} :core.macros)

(local {: format} string)
(local {: setup} (lazy-require! :bufferline))

;;; Setup bufferline
;; Setup
(setup {:options {:numbers (fn [opts]
                             (format "%s" (. opts :id)))
                  :max_name_length 20
                  :tab_size 20
                  :diagnostics :nvim_lsp
                  :offsets [{:filetype :help
                             :text "Help page"
                             :text_align :center}
                            {:filetype :packer
                             :text "Plugins manager"
                             :text_align :center}]
                  :show_buffer_icons true
                  :show_buffer_close_icons true
                  :show_close_button false
                  :sho_tab_indicators true
                  :persist_buffer_sort true
                  :separator_style :thick
                  :enforce_regular_tabs true
                  :always_show_bufferline false
                  :sort_by :directory
                  :indicator_icon "▎"
                  :modified_icon "●"
                  :close_icon ""}})
