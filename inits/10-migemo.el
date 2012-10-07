(when nil
(ari:when-require migemo
 (if (linuxp)
     (setq migemo-command "migemo"
           migemo-dictionary "/usr/share/migemo/migemo-dict")
     (setq migemo-command "/usr/local/bin/cmigemo"
           migemo-options '("-q" "--emacs" "-i" "\a")
           migemo-dictionary "/usr/local/share/migemo/utf-8/migemo-dict"))

 (setq migemo-user-dictionary nil
       migemo-coding-system 'utf-8-unix
       migemo-regex-dictionary nil)
 (setq moccur-use-migemo t)))
