;; Common lisp
(require 'cl-indent-patches nil t)
(when (file-exists-p (expand-file-name "~/quicklisp/slime-helper.el"))
  (load (expand-file-name "~/quicklisp/slime-helper.el")))
(ari:when-require slime
     (setq slime-default-lisp 'ccl)
     (setq slime-lisp-implementations
           '((ccl ("/usr/local/bin/ccl64") :coding-system utf-8-unix)
             (alisp ("/usr/local/bin/alisp") :coding-system utf-8-unix)
             (ecl ("/usr/local/bin/ecl")); :coding-system utf-8-unix)
             (cmucl ("/usr/local/bin/cmucl") :coding-system utf-8-unix)
             (sbcl ("/usr/local/bin/sbcl") :coding-system utf-8-unix)
             (clisp ("/usr/local/bin/clisp") :coding-system utf-8-unix)))
     (ari:add-hook-fn 'slime-mode-hook
                  (unless (slime-connected-p)
                    (save-excursion (slime)))
                  (global-set-key (kbd "C-c s") 'slime-selector)
                  (define-key slime-repl-mode-map (kbd "C-n") 'slime-repl-newline-and-indent)
                  (define-key slime-repl-mode-map (kbd "C-j") 'next-line)
                  (define-key slime-repl-mode-map (kbd "M-r") 'anything-for-files)
                  (define-key slime-scratch-mode-map (kbd "C-n") 'slime-eval-print-last-expression)
                  (define-key slime-scratch-mode-map (kbd "C-j") 'next-line)
;                  (define-key slime-repl-mode-map (kbd "s") 'slime-selector)
      )
     (setq slime-autodoc-use-multiline-p t)
     (slime-setup '(slime-repl slime-fancy slime-banner slime-js))
     ;(global-set-key [f5] 'slime-js-reload)
     (add-hook 'js2-mode-hook
               (lambda ()
                 (slime-js-minor-mode 1)))

     ;; ac-slime
     (ari:when-require ac-slime
          (ari:add-hook-fn 'slime-repl-mode-hook (set-up-slime-ac)))

     ;; for Clack
     (defun clack-slime-search-buffer-package ()
       (let ((case-fold-search t)
             (regexp (concat "^(\\(clack.util:\\)?namespace\\>[ \t']*"
                             "\\([^\n)]+\\)")))
         (save-excursion
           (if (or (re-search-backward regexp nil t)
                   (re-search-forward regexp nil t))
               (match-string-no-properties 2)
               (slime-search-buffer-package)))))
     (setq slime-find-buffer-package-function 'clack-slime-search-buffer-package)

     (setq cl-indent-keywords-patch-ignore-regexps '("(\\(clack.util:\\)?namespace" "(defpackage"))

     ;; cl-annot
     (font-lock-add-keywords 'lisp-mode '(("\\(?:^\\|[^,]\\)\\(@\\(?:\\sw\\|\\s_\\)+\\)" (1 font-lock-comment-face))))

     ;; CL-TEST-MORE
     (ari:when-require cl-test-more
       (defun slime-test-system (system)
         (interactive "SSystem: ")
         (slime-eval-in-repl (format "(ql:quickload :%s)" system))))
 )

;; Hyperspec
(defvar *anything-common-lisp-sources* nil)

(when (require 'hyperspec nil t)
  (setq common-lisp-hyperspec-root
        (concat "file:///" (getenv "HOME") "/Dropbox/Documents/HyperSpec/")
        common-lisp-hyperspec-symbol-table
        (concat common-lisp-hyperspec-root "Data/Map_Sym.txt"))
  (when (require 'popwin-w3m nil t)
    (push '("^file://.*HyperSpec.*\\.htm$" :height 0.4) popwin:w3m-special-display-config))

  (setf anything-c-source-hyperspec
        `((name . "Lookup Hyperspec")
          (candidates . ,(f0
                          (mapcar #'symbol-name
                                  (obarray-to-list common-lisp-hyperspec-symbols))))
          (action . (("Show Hyperspec" . hyperspec-lookup)))))
  (add-to-list '*anything-common-lisp-sources* 'anything-c-source-hyperspec))

;; CLtL2
(ari:when-require cltl2
  (setq cltl2-root-url (concat "file:///" (getenv "HOME") "/Dropbox/Documents/cltl/"))
  (setq anything-c-source-cltl2
        `((name . "Lookup CLtL2")
          (candidates . ,(f0
                          (mapcar #'symbol-name
                                  (obarray-to-list cltl2-symbols))))
          (action . (("Show CLtL2" . cltl2-lookup)))))
 (add-to-list '*anything-common-lisp-sources* 'anything-c-source-cltl2))

(defun anything-hyperspec-and-cltl2 ()
  (interactive)
  (anything (reverse *anything-common-lisp-sources*) (thing-at-point 'symbol)))
(global-set-key (kbd "M-l") 'anything-hyperspec-and-cltl2)

(defun set-pretty-patterns (patterns)
  (loop for (glyph . pairs) in patterns do
    (loop for (regexp . major-modes) in pairs do
      (loop for major-mode in major-modes do
        (let ((major-mode (intern (concat (symbol-name major-mode) "-mode")))
              (n (if (string-match "\\\\([^?]" regexp) 1 0)))
          (font-lock-add-keywords major-mode
                                  `((,regexp (0 (prog1 ()
                                                       (compose-region (match-beginning ,n)
                                                                       (match-end ,n)
                                                                       ,glyph)))))))))))
(set-pretty-patterns
 '((?Λ ("\\<lambda\\>" lisp lisp-interaction emacs-lisp scheme))
   (?φ ("\\<nil\\>" lisp lisp-interaction emacs-lisp scheme))
   (?Λ ("\\<function\\>" js2))))