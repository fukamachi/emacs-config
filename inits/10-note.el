(global-set-key "\C-cb"
                (lambda (file)
                  (interactive "sFile: ")
                  (find-file (concat "~/Dropbox/Documents/Blog/" file))))

(ari:when-require open-junk-file
  (setq open-junk-file-format "~/Dropbox/home/.emacs.d/junk/%Y/%m/%d-%H%M%S.")
  (global-set-key "\C-cj" 'open-junk-file)
  (global-set-key "\C-xj" 'open-junk-file))