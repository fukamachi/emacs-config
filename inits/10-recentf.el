(ari:when-require recentf-ext
     (setq recentf-max-saved-items 500)
     (setq recentf-exclude '("/TAGS$" "/var/tmp/"))
     (global-set-key (kbd "M-r") 'anything-for-files))