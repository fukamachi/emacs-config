(ari:when-require migemo
 (if (linuxp)
     (setq migemo-command "migemo"
           migemo-dictionary "/usr/share/migemo/migemo-dict"
           migemo-dictionary "/usr/share/migemo/migemo-dict")
     (setq migemo-command "/usr/local/bin/cmigemo"
           migemo-options '("-q" "--emacs" "-i" "\a")
           migemo-dictionary "/usr/local/share/migemo/euc-jp/migemo-dict"))

 (setq migemo-user-dictionary nil
  migemo-regex-dictionary nil)
 (setq moccur-use-migemo t))