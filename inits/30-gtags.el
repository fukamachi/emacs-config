(ari:when-autoloads (gtags-mode) "gtags"
  (local-set-key "\M-." 'gtags-find-tag)
  (local-set-key "\M-," 'gtags-pop-stack))
(ari:add-hook-fn 'c-mode-common-hook
 (gtags-mode t)
 (eval-after-load "gtags-mode" '(gtags-make-complete-list)))
(ari:add-hook-fn 'cperl-mode-hook
 (ari:when-require gtags
  (gtags-mode t)
  (eval-after-load "gtags-mode" '(gtags-make-complete-list))))
