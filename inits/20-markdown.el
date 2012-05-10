(ari:when-autoloads (markdown-mode) "markdown-mode"
  (define-key markdown-mode-map (kbd "C-=") 'markdown-cycle)
  (define-key markdown-mode-map (kbd "<tab>") 'ac-expand))
(ari:add-hook-fn 'markdown-mode-hook
                 (set (make-local-variable 'show-trailing-whitespace) nil))

(ari:when-autoloads (word-count-mode-on
                     word-count-mode-off) "word-count")

(ari:add-hook-fn 'markdown-mode-hook
  (word-count-mode-on))