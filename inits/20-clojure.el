;; Clojure
(ari:when-require clojure-mode)
;(ari:when-require swank-clojure
;  (add-to-list 'slime-lisp-implementations
;               `(clojure ,(swank-clojure-cmd) :init swank-clojure-init))
;  (add-hook 'slime-repl-mode-hook 'clojure-mode-font-lock-setup))

;(ari:when-autoloads (paredit-mode) "paredit"
;  (define-keys paredit-mode-map)
;  (define-key paredit-mode-map (kbd "M-r") 'anything-for-files)
;  (define-key paredit-mode-map (kbd "C-o") 'kill-sexp))