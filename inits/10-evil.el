;; Evil!

(ari:when-require evil
 (evil-mode 1)
 (define-key evil-insert-state-map (kbd "C-e") 'move-end-of-line)
 (define-key evil-normal-state-map (kbd "C-e") 'move-end-of-line)
 (define-key evil-insert-state-map (kbd "C-k") 'previous-line)
 (define-key evil-insert-state-map (kbd "C-j") 'next-line)

 (ari:define-key-fn evil-normal-state-map "D" (if paredit-mode (kill-sexp) (kill-line)))
 (ari:define-key-fn evil-normal-state-map "C"
  (if paredit-mode (kill-sexp) (kill-line))
  (evil-insert 1))

 (define-key evil-normal-state-map ")" 'paredit-forward-up)
 (define-key evil-normal-state-map "(" 'paredit-backward-up)
 (define-key evil-normal-state-map (kbd "C-0") 'paredit-backward-down)
 (define-key evil-normal-state-map (kbd "C-9") 'paredit-forward-down)

 (when (locate-library "slime")
   (define-key evil-normal-state-map (kbd "M-.") 'slime-edit-definition)
   (define-key evil-normal-state-map (kbd "M-,") 'slime-pop-find-definition-stack))

 (when (locate-library "elscreen")
   (define-key evil-normal-state-map "gp" 'elscreen-previous) ;previous tab
   (define-key evil-normal-state-map "gn" 'elscreen-next) ;next tab
   (define-key evil-normal-state-map "gt" 'elscreen-create)
   ))