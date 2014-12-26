;; css-mode
(ari:when-autoloads (css-mode) "css-mode"
  (setq cssm-indent-function 'cssm-c-style-indenter)
  (setq css-indent-offset 2))

(ari:when-autoloads (less-css-mode) "less-css-mode")

;; scss-mode

(ari:when-autoloads (scss-mode) "scss-mode"
  (setq scss-compile-at-save nil))
