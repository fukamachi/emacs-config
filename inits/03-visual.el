
;; 選択範囲をハイライト
(setq-default transient-mark-mode t)

;; バッファ一覧を詳細に
(global-set-key "\C-x\C-b" 'bs-show)

;; 対応するカッコをハイライト
(show-paren-mode t)

;; 全角空白、Tab、改行表示
(ari:when-require jaspace
  (setq jaspace-alternate-jaspace-string "□"
        jaspace-alternate-eol-string "↓\n"
        jaspace-highlight-tabs t)
  (ari-seq:append-to-list 'jaspace-modes (mapcar 'car my-fav-modes)))
(loop for m in (mapcar 'car my-fav-modes)
      do (progn
           (ari:add-hook-fn (ari-symbol:symbol-concat m '-hook)
                            (setq show-trailing-whitespace t)
                            (font-lock-add-keywords nil
                             '(("\\<\\(FIXME\\|TODO\\|BUG\\|NOTE\\|KLUDGE\\|XXX\\)" 1 font-lock-warning-face t))))
           (ari:add-hook-fn 'jaspace-mode-hook
                        (assq-delete-all 'jaspace-mode minor-mode-alist))))

(ari:add-hook-fn 'cperl-mode-hook
                 (font-lock-add-keywords nil '(("\\(throw\\|render\\)" 1 font-lock-keyword-face t))))

;; カーソル行をハイライト
(defface hlline-face
  '((((class color)
      (background dark))
     (:background "dark slate gray"))
    (((class color)
      (background light))
     (:background "ForestGreen"))
    (t
     ()))
  nil :group 'font-lock-highlighting-faces)
(setq hl-line-face 'hlline-face)
(global-hl-line-mode)

;; 表示不要なマイナーモードを削除
(loop for m in '(outputz undo-tree auto-complete jaspace)
      do (assq-delete-all (ari-symbol:symbol-concat m '-mode) minor-mode-alist))

;; モード行に行番号、桁番号を表示
(line-number-mode t)
(column-number-mode t)

;; モード行に時刻を表示
(setq display-time-string-forms '(24-hours ":" minutes))
(display-time)

;; モード行にバッテリ残量を表示
(display-battery-mode t)

;; 改行コードを表示
(setq eol-mnemonic-dos "(CRLF)"
      eol-mnemonic-mac "(CR)"
      eol-mnemonic-unix "(LF)")

;; 行間を開く
(setq-default line-spacing 0.1)

;; 日本語フォント
(defun set-jp-font (font)
  (when (display-graphic-p)
    (set-fontset-font
     (frame-parameter nil 'font)
     'japanese-jisx0208
     `(,font . "iso10646-1"))))
(ari:add-hook-fn 'window-setup-hook (set-jp-font "Hiragino Maru Gothic Pro"))

;;====================
;; Window System
;;====================
(when window-system
  (server-start) ;; Emacs serverを起動
  (set-frame-parameter nil 'alpha 85) ;; フレームを透過
  (menu-bar-mode 0) ;; メニューバーを消す
  (tool-bar-mode 0) ;; ツールバーを消す
  (toggle-scroll-bar nil)) ;; スクロールバーを消す

(defvar *current-frame-transparency* 85)

(defun set-frame-transparency (amount)
  (interactive "nTransparency: ")
  (set-frame-parameter nil 'alpha amount)
  (setq *current-frame-transparency* amount)
  (message (concat "Transparency: " (number-to-string *current-frame-transparency*))))

;; 不透明に
(defun frame-transparency-- ()
  (interactive)
  (set-frame-transparency (+ *current-frame-transparency* 5)))
(global-set-key (kbd "C-(") 'frame-transparency--)
;; 透明に
(defun frame-transparency-+ ()
  (interactive)
  (set-frame-transparency (- *current-frame-transparency* 5)))
(global-set-key (kbd "C-)") 'frame-transparency-+)
