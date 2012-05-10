;; CPerl
(defalias 'perl-mode 'cperl-mode)
(ari:when-autoloads (cperl-mode) "cperl-mode"
  (ari:when-require perltidy
       (defvar cperl-auto-tidy t)
       (defun perltidy-toggle ()
         (interactive)
         (setq cperl-auto-tidy (null cperl-auto-tidy))
         (message "Auto PerlTidy: %s"
                  (if cperl-auto-tidy
                      "Enabled"
                      "Disabled")))
       (defun cperl-save-buffer (&optional args)
         "Perltidy and save current buffer in visited file if modified."
         (interactive)
         (if (and (buffer-modified-p)
                  cperl-auto-tidy)
             (perltidy-buffer))
         (save-buffer)
         (ari:when-require point-undo
           (point-undo)))
       (defadvice perltidy-subroutine (after perltidy-subroutine-after activate)
         (when (functionp 'point-undo)
           (point-undo)))
       (define-key cperl-mode-map "\C-x\C-s" 'cperl-save-buffer))
  (setq cperl-indent-level 4
        cperl-close-paren-offset -4
        cperl-continued-statement-offset 4
        cperl-indent-parens-as-block t
        cperl-tab-always-indent t)
  (require 'set-perl5lib nil t)
  (define-key cperl-mode-map "\C-j" 'next-line))