;; php-mode
(ari:when-autoloads (php-mode) "php-mode")
(ari:add-hook-fn 'php-mode-hook
             (setq tab-width 2)
             (c-set-offset 'substatement-open 0)
             (c-set-offset 'block-open '+)
             (c-set-offset 'case-label 1)
             (c-set-offset 'statement-case-open 0)
             (c-set-offset 'arglist-intro '+)
             (c-set-offset 'arglist-close 0))