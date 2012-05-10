(add-hook 'find-file-hooks 'auto-insert)
(setq auto-insert-directory "~/Dropbox/home/.emacs.d/templates"
      auto-insert-alist
      '((perl-mode . "perl-template.pl")
        (html-mode . "html-template.html")
        ("base\\.css" . "base.css")
        (css-mode . "css-template.css")
        (".*\\.class\\.php$" . ["php-class-template.php" my-template])))

(defvar template-replacements-alists
  '(("%file%"             . (f0 (file-name-nondirectory (buffer-file-name))))
    ("%file-without-ext%" . (f0 (file-name-sans-extension (file-name-nondirectory (buffer-file-name)))))
    ("%name%" . user-full-name)
    ("%mail%" . user-mail-address)
    ("%directory-name%" . (f0 (file-name-parent-directory (buffer-file-name))))))

(defun my-template ()
  (time-stamp)
  (mapc (f_ (goto-char (point-min))
            (while (re-search-forward (car _) nil t)
              (replace-match (funcall (cdr _)))))
        template-replacements-alists)
  (goto-char (point-max))
  (message "done."))