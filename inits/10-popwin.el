(ari:when-require popwin
  (setq display-buffer-function 'popwin:display-buffer)
  (when (fboundp 'popwin:w3m-browse-url)
    (setq browse-url-browser-function 'popwin:w3m-browse-url))
  (ari-seq:append-to-list
   'popwin:special-display-config
   '(("*anything for files*")
     ("*anything find-file*")
     ("*anything moccur*")
     ("*anything complete*")
     ("*anything*")
     ("*w3m*")
     ("*slime-apropos*")
     ("*slime-macroexpansion*")
     ("*slime-description*")
     ("*slime-compilation*" :noselect t)
     ("*slime-xref*")
     ;(slime-repl-mode)
     (slime-connection-list-mode)
     (sldb-mode :height 20 :stick t)
     (direx:direx-mode :position left :width 35 :dedicated t))))
