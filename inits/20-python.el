(ari:when-autoloads (jedi:ac-setup jedi:setup) "jedi"
 (setq jedi:tooltip-method nil)
 (set-face-attribute 'jedi:highlight-function-argument nil
                     :foreground "green"))
(add-hook 'python-mode-hook 'jedi:setup)

(setq python-check-commands
      (loop for cmd in '("pyflakes"
                         "pep8 --repeat")
            if (has-shell-command (substring cmd 0 (position ?\s cmd)))
              collect cmd))

(when (and python-check-commands
           (load "flymake" t))
  (defun flymake-pyflakes-init ()
    (let* ((temp-file (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-inplace))
           (local-file (file-relative-name
                        temp-file
                        (file-name-directory buffer-file-name))))
      (labels ((concat-shell-commands (commands)
                 (loop with shell-command = ""
                       for cmd in commands
                       do (setq shell-command
                                (concat shell-command cmd " " local-file "; "))
                       finally (return shell-command))))
        `("zsh" ("-c" ,(concat-shell-commands python-check-commands))))))
  (add-to-list 'flymake-allowed-file-name-masks
               '("\\.py\\'" flymake-pyflakes-init))
  (require 'flymake-cursor nil t)
  (add-hook 'python-mode-hook 'flymake-mode))
