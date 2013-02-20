;; Tetris
(setq tetris-score-file "~/Dropbox/home/.emacs.d/tetris-score-file")

;; Aozora Bunko
(require 'aozora-view nil t)

(ari:when-require kindly-mode
 (ari:when-require jaspace
    (add-hook 'kindly-mode-hook 'jaspace-mode-off))
 (global-set-key (kbd "<f2>") 'kindly-mode))

(defun say-at-point ()
  (interactive)
  (say (if mark-active
           (buffer-substring (region-beginning) (region-end))
           (thing-at-point 'word))))
(defun say (word)
  (interactive (list
                (read-string (format "Word (%s): "
                                     (thing-at-point 'word))
                             nil nil (thing-at-point 'word))))
  (shell-command (concat "say " word)))
