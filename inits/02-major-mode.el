;; よく使うモード
(defvar my-fav-modes
  '((emacs-lisp-mode . "\\.el$")
    (lisp-mode . "\\.\\(cl\\|lisp\\)$")
    (scheme-mode . "\\.scm$")
    (clojure-mode . "\\.clj$")
    (pir-mode . "\\.\\(imc\\|pir\\)$")
;    (malabar-mode . "\\.java$")
    (perl-mode . "\\.\\(pl\\|t\\|psgi\\)$")
    (php-mode . "\\.php[45]?$")
    (yaml-mode . "\\.ya?ml$")
    (js2-mode . "\\.js$")
    (ruby-mode . "\\.rb$")
    (text-mode . "\\.txt$")
    (fundamental-mode . nil)
    (LaTeX-mode . "\\.tex$")
    (org-mode . "\\.org$")
    (css-mode . "\\.css$")
    (nxml-mode . "\\.\\(xml\\|svg\\|wsdl\\|xslt\\|wsdd\\|xsl\\|rng\\|xhtml\\|jsp\\|tag\\)$")
    (markdown-mode . "\\.\\(md\\|markdown\\)$")
    (html-mode . "\\.\\(html\\|htm\\|emb\\|tmpl\\)$")
    (hatena-diary-mode . "\\.htn$")))

;; auto-mode-alist
(loop for (k . v) in my-fav-modes
      do (unless (null v) (add-to-list 'auto-mode-alist (cons v k))))