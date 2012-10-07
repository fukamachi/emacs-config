;; ElScreen
;; EmacsでGNU screen風のインターフェイスを使う
(ari:when-require elscreen
  (setq elscreen-prefix-key "\C-z"
        elscreen-display-tab nil)
  (defun elscreen-frame-title-update ()
    (when (elscreen-screen-modified-p 'elscreen-frame-title-update)
      (let* ((screen-list (sort (elscreen-get-screen-list) '<))
             (screen-to-name-alist (elscreen-get-screen-to-name-alist))
             (title (mapconcat
                     (lambda (screen)
                       (format "%d%s %s"
                               screen (elscreen-status-label screen)
                               (get-alist screen screen-to-name-alist)))
                     screen-list " ")))
        (if (fboundp 'set-frame-name)
            (set-frame-name title)
          (setq frame-title-format title)))))
  (add-hook 'elscreen-screen-update-hook 'elscreen-frame-title-update))
