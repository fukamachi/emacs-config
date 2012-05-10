;; git commit
(ari:add-hook-fn 'server-visit-hook
             (if (string-match "COMMIT_EDITMSG" buffer-file-name)
                 (set-buffer-file-coding-system 'utf-8)))

(require 'git-status nil t)
(require 'hg-status nil t)

(defun git-blame-current-line ()
  (interactive)
  (let ((old-buf (current-buffer))
    (blame-buf (get-buffer-create "*blame*"))
    (line-num (number-to-string (line-number-at-pos))))
    (set-buffer blame-buf)
    (erase-buffer)
    (call-process "git-blame-oneline" nil "*blame*" t (buffer-file-name old-buf) line-num)
    (setq content (buffer-string))
    (set-buffer old-buf)
    (when (not (eq (length content) 0))
      (popup-tip content)
      ; (message content)
      )
    ))