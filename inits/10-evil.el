;; Evil!

(ari:when-require evil
 (evil-mode 1)
 (define-key evil-insert-state-map (kbd "C-e") 'move-end-of-line)
 (define-key evil-normal-state-map (kbd "C-e") 'move-end-of-line)
 (define-key evil-insert-state-map (kbd "C-k") 'previous-line)
 (define-key evil-insert-state-map (kbd "C-j") 'next-line)

 (ari:define-key-fn evil-normal-state-map "D" (if (and (boundp 'paredit-mode) paredit-mode) (kill-sexp) (kill-line)))
 (ari:define-key-fn evil-normal-state-map "C"
  (if (and (boundp 'paredit-mode) paredit-mode) (kill-sexp) (kill-line))
  (evil-insert 1))

 (evil-define-key 'normal paredit-mode ")" 'paredit-forward-up)
 (evil-define-key 'normal paredit-mode "(" 'paredit-backward-up)
 (evil-define-key 'normal paredit-mode (kbd "C-0") 'paredit-backward-down)
 (evil-define-key 'normal paredit-mode (kbd "C-9") 'paredit-forward-down)

 (when (locate-library "slime")
   (define-key evil-normal-state-map (kbd "M-.") 'slime-edit-definition)
   (define-key evil-normal-state-map (kbd "M-,") 'slime-pop-find-definition-stack))

 (when (locate-library "elscreen")
   (define-key evil-normal-state-map "gp" 'elscreen-previous) ;previous tab
   (define-key evil-normal-state-map "gn" 'elscreen-next) ;next tab
   (define-key evil-normal-state-map "gt" 'elscreen-create))

 (when (locate-library "direx")
   (evil-define-key 'normal direx-mode "j" 'direx:next-node)
   (evil-define-key 'normal direx-mode "k" 'direx:previous-node))
   (define-key evil-normal-state-map (kbd "RET") 'direx:maybe-find-node))
