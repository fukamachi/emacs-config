;; Titanium
(ari:when-require titanium
 (global-titanium t))

(ari:when-require ac-titanium-mobile
 (ari:add-hook-fn 'js2-mode-hook
  (make-local-variable 'ac-sources)
  (setq ac-sources '(ac-source-titanium-mobile))))

(defun ti-send-run ()
  (interactive)
  (let ((builder
         (expand-file-name "~/Library/Application\\ Support/Titanium/mobilesdk/osx/1.8.0.1/iphone/builder.py")))
    (shell-command (concat builder " run /Users/nitro_idiot/Programs/web/clank/mobile"))))