;; Evil!

(ari:when-require evil
 (evil-mode 1)
 (define-key evil-insert-state-map (kbd "C-e") 'move-end-of-line)
 (define-key evil-normal-state-map (kbd "C-e") 'move-end-of-line)
 (define-key evil-insert-state-map (kbd "C-k") 'previous-line)
 (define-key evil-insert-state-map (kbd "C-j") 'next-line)

 (when (locate-library "slime")
  (define-key evil-normal-state-map (kbd "M-.") 'slime-edit-definition)
  (define-key evil-normal-state-map (kbd "M-,") 'slime-pop-find-definition-stack))

 (when (locate-library "elscreen")
  (define-key evil-normal-state-map "gp" 'elscreen-previous) ;previous tab
  (define-key evil-normal-state-map "gn" 'elscreen-next) ;next tab
  (define-key evil-normal-state-map "gt" 'elscreen-create)
  ))