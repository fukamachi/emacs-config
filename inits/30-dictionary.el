(ari:when-require dictionary
 (setq dict-bin
  (if (linuxp)
      "~/Dropbox/home/.emacs.d/elisp/dictionary/dict"
      "~/Dropbox/home/.emacs.d/elisp/dictionary/dict.py")))