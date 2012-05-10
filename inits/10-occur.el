;; M-x occurで検索結果を一覧
(ari:when-autoloads (occur moccur moccur-grep moccur-grep-find) "color-moccur"
  (setq moccur-split-word t))

;; anything-c-moccur
(ari:when-autoloads (anything-c-moccur-occur-by-moccur
                     anything-c-moccur-dmoccur
                     anything-c-moccur-dired-do-moccur-by-moccur) "anything-c-moccur"
  (setq anything-c-moccur-anything-idle-delay 0.2 ;`anything-idle-delay'
        anything-c-moccur-higligt-info-line-flag t ; `anything-c-moccur-dmoccur'などのコマンドでバッファ情報をハイライト
        anything-c-moccur-enable-auto-look-flag t ; 現在選択中の候補の位置を他のwindowに表示
        anything-c-moccur-enable-initial-pattern t)) ; `anything-c-moccur-occur-by-moccur'の起動時にポイントの位置の単語を初期パターンにする

(global-set-key (kbd "M-o") 'anything-c-moccur-occur-by-moccur) ;バッファ内検索
(global-set-key (kbd "C-M-o") 'anything-c-moccur-dmoccur) ;ディレクトリ
