;; Parrot
(ari:when-autoloads (pir-mode) "pir-mode"
  (define-key pir-mode-map "\C-j" 'next-line))