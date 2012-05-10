(ari:when-require auto-complete
     (global-auto-complete-mode t)
     (ari-seq:append-to-list 'ac-modes (mapcar 'car my-fav-modes))
     (ari-seq:append-to-list 'ac-modes '(slime-mode slime-repl-mode)))