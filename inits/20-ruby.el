;; ruby
(add-to-list 'interpreter-mode-alist '("ruby" . ruby-mode))
(ari:when-autoloads (run-ruby inf-ruby-keys) "inf-ruby"
  (ari:add-hook-fn 'ruby-mode-hook (inf-ruby-keys)))

(ari:when-autoloads (ruby-electric-mode) "ruby-electric")
(ari:when-autoloads (ruby-block-mode) "ruby-block"
  (setq ruby-block-highlight-toggle t))
(ari:add-hook-fn 'ruby-mode-hook (ruby-electric-mode t) (ruby-block-mode t))

(ari:when-autoloads (rubydb) "rubydb3x")