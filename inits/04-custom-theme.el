;; color-themeの設定
(ari:when-require color-theme-tangotango
  (color-theme-tangotango))

;; 括弧の色を薄く
(defvar paren-face 'paren-face)
(make-face 'paren-face)
(set-face-foreground 'paren-face "#666666")

(dolist (mode '(lisp-mode
                emacs-lisp-mode
                scheme-mode))
  (font-lock-add-keywords mode
                          '(("(\\|)" . paren-face))))
