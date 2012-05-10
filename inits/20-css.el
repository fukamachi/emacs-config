;; css-mode
(ari:when-autoloads (css-mode) "css-mode"
  (setq cssm-indent-function 'cssm-c-style-indenter)
  (setq css-indent-offset 2))