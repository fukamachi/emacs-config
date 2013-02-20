(ari:when-require recentf-ext
     (setq recentf-max-saved-items 3000)
     (setq recentf-exclude '("/TAGS$" "/var/tmp/"))
     (global-set-key (kbd "M-r") 'anything-for-files)
     (ari:add-hook-fn 'paredit-mode-hook
      (define-key paredit-mode-map (kbd "M-r") 'anything-for-files)))
