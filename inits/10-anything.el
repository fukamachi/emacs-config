(ari:when-require anything-startup
 (global-set-key (kbd "C-x C-f") 'anything-find-file)
 (define-key anything-map "\C-j" 'anything-next-line)
 (define-key anything-map "\C-k" 'anything-previous-line)
 (define-key anything-map "\M-j" 'anything-next-page)
 (define-key anything-map "\M-k" 'anything-previous-page))