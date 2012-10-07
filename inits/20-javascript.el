;; js2-mode
(ari:when-autoloads (js2-mode) "js2"
  (setq js2-basic-offset 4
        js2-mirror-mode nil)
  (ari:when-require espresso
       (setq espresso-indent-level 4
             espresso-expr-indent-offset 4
             indent-tabs-mode nil)
   (defun my-js-indent-line ()
    (interactive)
    (let* ((parse-status (save-excursion (syntax-ppss (point-at-bol))))
           (offset (- (current-column) (current-indentation)))
           (indentation (espresso--proper-indentation parse-status))
           (type (js2-node-type (js2-node-at-point (- (point) 2)))))
     (back-to-indentation)
     (cond
      ((looking-at "case\\s-")
       (setq indentation (+ indentation 2)))
      ((or (= js2-CALL type) (= js2-FUNCTION type))
       (setq indentation (+ indentation 2))))
     (indent-line-to indentation)
     (when (> offset 0) (forward-char offset))))
   (ari:add-hook-fn 'js2-mode-hook
    (font-lock-add-keywords nil
     '(("^[^\n]\\{80\\}\\(.*\\)$" 1 font-lock-warning-face t)))
    (set (make-local-variable 'indent-line-function) 'my-js-indent-line))))