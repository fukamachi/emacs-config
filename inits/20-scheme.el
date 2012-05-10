;; Gauche
(ari:when-autoloads (scheme-mode run-scheme) "cmuscheme"
  (add-to-list 'process-coding-system-alist '("gosh" utf-8 . utf-8))
  (setq scheme-program-name "gosh -i"))