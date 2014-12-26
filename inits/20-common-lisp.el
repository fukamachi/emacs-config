;; Common lisp

(when (file-exists-p (expand-file-name "~/quicklisp/slime-helper.el"))
  (load (expand-file-name "~/quicklisp/slime-helper.el")))

(require 'slime-autoloads nil t)

(when (file-exists-p (expand-file-name "~/quicklisp/log4slime-setup.el"))
  (load (expand-file-name "~/quicklisp/log4slime-setup.el"))
  (global-log4slime-mode 1))

(ari:when-require slime
  (setq slime-default-lisp 'sbcl)
  (setq slime-lisp-implementations
        `((ccl ("~/.cim/bin/ccl-1.9") :coding-system utf-8-unix)
          (alisp ("/usr/local/bin/alisp") :coding-system utf-8-unix)
          (ecl ("/usr/local/bin/ecl"))  ; :coding-system utf-8-unix)
          (cmucl ("/usr/local/bin/cmucl") :coding-system utf-8-unix)
          (sbcl ("ros" "+R" "-l" "~/.sbclrc" "run") :coding-system utf-8-unix)
          (abcl ("~/.cim/bin/abcl-1.3.1" "-XX:MaxPermSize=256m" "-Dfile.encoding=UTF-8") :coding-system utf-8-unix)
          (clisp ("/usr/local/bin/clisp") :coding-system utf-8-unix)))
  (ari:add-hook-fn 'slime-mode-hook
                   (unless (slime-connected-p)
                     (save-excursion (slime)))
                   (global-set-key (kbd "C-c s") 'slime-selector)
                   (define-key slime-repl-mode-map (kbd "C-n") 'slime-repl-newline-and-indent)
                   (define-key slime-repl-mode-map (kbd "C-j") 'next-line)
                   (define-key slime-repl-mode-map (kbd "M-r") 'anything-for-files)
                   (define-key slime-scratch-mode-map (kbd "C-n") 'slime-eval-print-last-expression)
                   (define-key slime-scratch-mode-map (kbd "C-j") 'next-line))
  (setq slime-autodoc-use-multiline-p t)
  (slime-setup '(slime-repl slime-fancy slime-repl-ansi-color slime-banner slime-indentation slime-js))
  (when (file-exists-p (expand-file-name "~/Programs/lib/cl21/cl21-mode.el"))
    (load (expand-file-name "~/Programs/lib/cl21/cl21-mode.el")))
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

  ;; CL-TEST-MORE
  (ari:when-require cl-test-more
    (defun slime-test-system (system)
      (interactive "SSystem: ")
      (slime-eval-in-repl (format "(asdf:test-system :%s)" system)))))

;; Syntax table
(modify-syntax-entry ?\[ "(]" lisp-mode-syntax-table)
(modify-syntax-entry ?\] ")[" lisp-mode-syntax-table)
(modify-syntax-entry ?\{ "(}" lisp-mode-syntax-table)
(modify-syntax-entry ?\} "){" lisp-mode-syntax-table)

;; cl-annot
(font-lock-add-keywords 'lisp-mode '(("\\(?:^\\|[^,]\\)\\(@\\(?:\\sw\\|\\s_\\)+\\)" (1 font-lock-comment-face))))
;; Dylan-style class naming
(font-lock-add-keywords 'lisp-mode '(("\\(?:^\\|[^,:]\\)\\(<\\(?:\\sw\\|\\s_\\)+>\\)" (1 font-lock-type-face))))

;; Paredit keys
(eval-after-load "paredit"
  '(progn
    (define-key paredit-mode-map "[" 'paredit-open-bracket)
    (define-key paredit-mode-map "]" 'paredit-close-bracket)
    (define-key paredit-mode-map "(" 'paredit-open-parenthesis)
    (define-key paredit-mode-map ")" 'paredit-close-parenthesis)
    (define-key paredit-mode-map "{" 'paredit-open-curly)
    (define-key paredit-mode-map "}" 'paredit-close-curly)))

;; ParEdit
(ari:when-autoloads (paredit-mode) "paredit"
 (global-set-key (kbd "M-l") 'paredit-forward-slurp-sexp)
 (global-set-key (kbd "M-h") 'paredit-forward-barf-sexp)
 (global-set-key (kbd "M-9") 'paredit-wrap-round)
 (define-key paredit-mode-map (kbd "C-j") 'next-line)
 (define-key paredit-mode-map (kbd "C-k") 'previous-line))
(loop for mode in '(emacs-lisp-mode
                    lisp-mode
                    lisp-interaction-mode
                    scheme-mode)
      collect (ari:add-hook-fn (intern (concat (symbol-name mode) "-hook"))
                 (paredit-mode t)))

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
  (anything (reverse *anything-common-lisp-sources*) ""))
(global-set-key (kbd "M-?") 'anything-hyperspec-and-cltl2)

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
 '((?λ ("\\<lambda\\>" lisp lisp-interaction emacs-lisp scheme))
   (?φ ("\\<nil\\>" lisp lisp-interaction emacs-lisp scheme))
   (?λ ("\\<function\\>" js2))))

(defun closure-compile ()
  (interactive)
  (let ((name (buffer-file-name)))
    (save-buffer)
    (slime-eval `(cl:progn
                  (closure-template:compile-cl-templates (cl:pathname ,name))
                  nil)
                'cl-user)
    (message name)))

(ari:when-require closure-template-html-mode
 (add-hook 'closure-template-html-mode-hook
  (lambda ()
    (interactive)
    (local-set-key (kbd "C-c C-g") 'closure-compile))))
