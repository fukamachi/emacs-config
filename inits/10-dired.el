;; wdired
(ari:add-hook-fn 'dired-mode-hook
             (ari:when-require wdired
                  (define-key dired-mode-map "r" 'wdired-change-to-wdired-mode)))

;; direx
(ari:when-require direx
 (global-set-key (kbd "C-c d") 'direx:find-directory-other-window)
 (global-set-key (kbd "C-c C-d") 'direx:find-directory-other-window)
 (global-set-key (kbd "C-c C-j") 'direx:jump-to-directory-other-window))
