
;;カラーテーマ設定
;; color-theme.el
(when (require 'color-theme)
  (color-theme-initialize)
  ;;(color-theme-subtle-hacker)
  ;;(color-theme-robin-hood)
  ;;(color-theme-resolve)
  (color-theme-shaman)
  ;;(color-theme-snowish)
  ;;(color-theme-dark-blue)
  ;;(color-theme-lethe)
  ;;(color-theme-hober)
  ;;(color-theme-dark-laptop)
  ;;(color-theme-arjen)
  ;;(color-theme-midnight)
  ;;(color-theme-jonadabian)
  ;; color-theme-solorized.el
  ;;(when (require 'color-theme-solarized)
    ;;(color-theme-solarized-dark)
    ;;(color-theme-solarized-light)
    ;)
  )


(set-language-environment 'Japanese)
(prefer-coding-system 'utf-8)
;; クリップボードの文字コード
(set-selection-coding-system 'utf-8)
;; 端末の文字コード
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
;; ファイル名の文字コードt
(require 'ucs-normalize)
(set-file-name-coding-system 'utf-8-hfs)



;;フォント関係の設定
(if (eq window-system 'mac)(progn
(create-fontset-from-ascii-font "Menlo-14:weight=normal:slant=normal" nil "menlokakugo")
(set-fontset-font "fontset-menlokakugo" 'unicode (font-spec :family "Hiragino Maru Gothic ProN" ) nil 'append)
(add-to-list 'default-frame-alist '(font . "fontset-menlokakugo"))
(setq face-font-rescale-alist '((".*Hiragino.*" . 1.0) (".*Menlo.*" . 1.0)))))



(setq frame-title-format
      (format "%%f - Emacs@%s" (system-name)))


;;フォントとかの変更
(set-face-attribute 'default nil
:height 140)


;;ツールバーの非表示
(tool-bar-mode -1)

;;透明度の設定
(add-to-list 'default-frame-alist '(alpha .(90 90)))



;;対応する括弧を表示
;;(show-paren-mode t)



;;改行するとインデント
(global-set-key "\C-m" 'newline-and-indent)
;;deleteキーで削除
(delete-selection-mode 1)
;;編集行のハイライト
;;(global-hl-line-mode)



;;音消す
(setq visible-bell t)

;;カーソルの行と列をモードラインに表示
(setq line-number-mode t)
;;(setq column-number-mode t)

;;ファイルサイズを表示
(setq size-indication-mode t)

;;インデントをspace*4に
(setq-default c-basic-offset 4)

;MakefileのときだけはちゃんとTABになるように
(add-hook 'makefile-mode-hook
  (function (lambda ()
    (setq indent-tabs-mode t))))

;; 関数内の強調表示
(show-paren-mode 1)
(setq show-paren-delay 0)
(setq show-paren-style 'expression)
;;(set-face-attribute 'show-paren-match-face nil :background "#0d5e56" :foreground "#ffffff")
;;(set-face-attribute 'border "#0d5e56")


;; "yes or no" を "y or n" にする
(fset 'yes-or-no-p 'y-or-n-p)


;;現在いる関数名を教えてくれる
(which-function-mode 1)



(defun my-toggle-fullscreen ()
  "Toggle fullscreen."
  (interactive)
  (if (eq (frame-parameter nil 'fullscreen) 'fullboth)
      (progn
        (set-frame-parameter nil 'fullscreen nil)
        (display-time-mode 0))
    (set-frame-parameter nil 'fullscreen 'fullboth)
    (display-time-mode 1)))

(global-set-key "\C-cf" 'my-toggle-fullscreen)
