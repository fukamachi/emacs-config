(ari:when-autoloads (e2wm:start-management) "e2wm"
  (e2wm:add-keymap
   e2wm:pst-minor-mode-keymap
   '(("M-h" . e2wm:dp-code) ; codeへ変更
     ("M-l"  . e2wm:dp-two)  ; twoへ変更
     ("M-k"    . e2wm:dp-array)  ; arrayへ変更
     ("M-j"  . e2wm:dp-dashboard) ; dashboardへ変更
     ("C-."       . e2wm:pst-history-forward-command) ; 履歴を進む
     ("C-,"       . e2wm:pst-history-back-command) ; 履歴をもどる
     ("prefix L"  . ielm)
     ) e2wm:prefix-key)
  (setq e2wm:c-dashboard-plugins
        '((open :plugin-args (:command twit :buffer "*twittering*"))
          (open :plugin-args (:command doctor :buffer "*doctor*")))))