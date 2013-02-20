;; Command-Key and Option-Key
(when (mac-os-p)
  (setq ns-command-modifier 'meta)
  (setq ns-alternate-modifier 'super)
  (setq mac-pass-command-to-system nil))

;; フォントサイズ変更
(defun font-big ()
 (interactive)
 (set-face-attribute 'default nil :height
  (+ (face-attribute 'default :height) 10))
 (set-jp-font))

(defun font-small ()
 (interactive)
 (set-face-attribute 'default nil :height
  (- (face-attribute 'default :height) 10))
 (set-jp-font))

(defun toggle-fullscreen ()
  (interactive)
  (cond
    ((mac-os-p) (ns-toggle-fullscreen))
    ((linuxp)
     (if (frame-parameter nil 'fullscreen)
         (set-frame-parameter nil 'fullscreen nil)
         (set-frame-parameter nil 'fullscreen 'fullboth)))))

(defvar my-key-binds
    `(("\C-h" . backward-char)
      ("\C-j" . next-line)
      ("\C-k" . previous-line)
      ("\C-l" . forward-char)
      ("\C-n" . newline-and-indent)
      ("\C-o" . kill-line)
      (,(kbd "C-'") . recenter)
      ("\C-f" . anything-next-page)
      ("\C-b" . anything-previous-page)
      (,(kbd "C-;") . ari-cursor:search-repeat-with-char)
      ("\M-s" . query-replace-regexp)
      ("\M-d" . ari-cursor:kill-word-at-point)
      ("\M-g" . goto-line)
      (,(kbd "C-c m") . toggle-fullscreen)
      (,(kbd "C--") . font-small)
      (,(kbd "C-+") . font-big)
      (,(kbd "C-c M-n") . new-frame)))

(defun define-keys (&optional mode)
  (loop for (key . fn) in my-key-binds
        do (if mode
               (define-key mode key fn)
               (global-set-key key fn))))

(define-keys)

(defun next-file (&optional reversep)
  (let* ((filename (file-name-nondirectory (buffer-file-name)))
         (dirname (file-name-directory (buffer-file-name)))
         (dir-files
          (remove-if (lambda (f) (or (string= f ".")
                                (string= f "..")))
                     (directory-files dirname))))
    (when reversep
      (setq dir-files
            (nreverse dir-files)))
    (loop while dir-files
          for file = (pop dir-files)
          if (string= file filename)
            return (car dir-files))))
(defun open-next-file ()
  (interactive)
  (ari:aif (next-file)
    (find-file it)
    (message "Nothing to see anymore.")))
(defun open-previous-file ()
  (interactive)
  (ari:aif (next-file t)
    (find-file it)
    (message "Nothing to see anymore.")))
(global-set-key (kbd "M-<down>") 'open-next-file)
(global-set-key (kbd "M-<up>") 'open-previous-file)

;;====================
;; Window
;;====================
(define-prefix-command 'windmove-map)
(global-set-key (kbd "C-q") 'windmove-map)
(define-key windmove-map "h" 'windmove-left)
(define-key windmove-map "j" 'windmove-down)
(define-key windmove-map "k" 'windmove-up)
(define-key windmove-map "l" 'windmove-right)
(define-key windmove-map "0" 'delete-window)
(define-key windmove-map "1" 'delete-other-windows)
(define-key windmove-map "2" 'split-window-vertically)
(define-key windmove-map "3" 'split-window-horizontally)

;; windowを分割・削除したときに幅をあわせる＋別のwindowに移動
;(ari:defadvice-many (split-window-vertically
;                     split-window-horizontally
;                     delete-window) after
;  (balance-windows)
;  (other-window 1))
(defun split-window-conditional ()
  (interactive)
  (if (> (* (window-height) 2) (window-width))
      (split-window-vertically)
    (split-window-horizontally)))
(define-key windmove-map "s" 'split-window-conditional)
(ari:define-key-fn windmove-map "n"
  (split-window-conditional) (switch-to-buffer "*scratch*"))

; 画面の3分割
; http://d.hatena.ne.jp/yascentur/20110621/1308585547
(defun split-window-vertically-n (num_wins)
  (interactive "p")
  (if (= num_wins 2)
      (split-window-vertically)
    (progn
      (split-window-vertically
       (- (window-height) (/ (window-height) num_wins)))
      (split-window-vertically-n (- num_wins 1)))))
(defun split-window-horizontally-n (num_wins)
  (interactive "p")
  (if (= num_wins 2)
      (split-window-horizontally)
    (progn
      (split-window-horizontally
       (- (window-width) (/ (window-width) num_wins)))
      (split-window-horizontally-n (- num_wins 1)))))
(global-set-key "\C-x@" '(lambda ()
                           (interactive)
                           (split-window-vertically-n 3)))
(global-set-key "\C-x!" '(lambda ()
                           (interactive)
                           (split-window-horizontally-n 3)))

;;====================
;; Killing
;;====================
;; minibufferでC-wで前の単語を削除
(define-key minibuffer-local-completion-map (kbd "C-w") 'backward-kill-word)

;; 範囲指定していないとき、C-wで前の単語を削除
(defadvice kill-region (around kill-word-or-kill-region activate)
  (if (and (interactive-p) transient-mark-mode (not mark-active))
      (backward-kill-word 1)
    ad-do-it))

;; C-kで行が連結したときにインデントを減らす
(defadvice kill-line (before kill-line-and-fixup activate)
  (when (and (not (bolp)) (eolp))
    (forward-char)
    (fixup-whitespace)
    (backward-char)))

(defadvice kill-sexp (around kill-sexp-and-fixup activate)
  (if (and (not (bolp)) (eolp))
      (progn
        (forward-char)
        (fixup-whitespace)
        (backward-char)
        (kill-line))
      ad-do-it))
