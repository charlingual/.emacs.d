;;load-pathを読み込む関数らしい
(when (< emacs-major-version 23)
        (defvar user-emacs-directory "~/.emacs.d/"))

(defun add-to-load-path (&rest paths)
  (let (path)
    (dolist (path paths paths)
      (let ((default-directory
              (expand-file-name (concat user-emacs-directory path))))
        (add-to-list 'load-path default-directory)
        (if (fboundp 'normal-top-level-add-subdirs-to-load-path)
            (normal-top-level-add-subdirs-to-load-path))))))

;;具体的なパスの場所
(add-to-load-path "elisp" "site-lisp")
;;読み込みファイル一覧
;;(load "flmake-init")
;;(load "flymake-cursor")
(load "scroll")
(load "style")
(load "hiding")
(load "key-binding")
(load "yatex-init")
(load "shell-toggle-init")
;;(load "tabbar-init")

;;flycheckを有効に
(setq-default flycheck-clang-language-standard "c++11")
(setq flycheck-clang-include-path
      (list (expand-file-name "~/usr/include")))
(add-hook 'after-init-hook #'global-flycheck-mode)
(add-hook 'python-mode-hook 'flycheck-mode)

;;置換した時に大文字小文字をそのままにする
(setq case-replace nil)


;;markdown用
(autoload 'markdown-mode "markdown-mode.el" "Major mode for editing Markdown files" t)
(setq auto-mode-alist (cons '("\\.md" . markdown-mode) auto-mode-alist))
(setq markdown-css-path
      "/Users/yau/.emacs.d/elisp/markdown-mode-2.0/css/github.css")


;;SPARQL mode
(autoload 'sparql-mode "sparql-mode.el"
    "Major mode for editing SPARQL files" t)
(add-to-list 'auto-mode-alist '("\\.sparql$" . sparql-mode))


;;rails用
(require 'rinari)
(global-rinari-mode t)


;;.erbとか用
(require 'rhtml-mode)
(add-hook 'rhtml-mode-hook
    (lambda () (rinari-launch)))



;;ヘッダファイルのメジャーモードをc++に変更。置く場所要検討
(add-to-list 'auto-mode-alist '("\\.h$" . c++-mode))


;;何かスペルミスを指摘してくれるらしい
(setq-default flyspell-mode t)
(setq ispell-dictionary "american")


;;aspellの設定,ispellと入れ替え
(setq-default ispell-program-name "aspell")
(eval-after-load "ispell"
  '(add-to-list 'ispell-skip-region-alist '("[^\000-\377]+")))
(mapc
 (lambda (hook)
   (add-hook hook
             '(lambda () (flyspell-mode 1))))
 '(
   yatex-mode-hook
   ))

;;デフォのvcモードとかいうやつをoffに
(setq vc-handled-backends ())


;; 行番号の表示
;(require 'linum)
;(global-linum-mode t)
;(setq linum-format "%3d ")







;; el-get インストール後のロードパスの用意
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")
;; もし el-get がなければインストールを行う
(unless(require 'el-get nil t)
  (url-retrieve
   "https://github.com/dimitri/el-get/raw/master/el-get-install.el"
   (lambda (s)
     (let (el-get-master-branch)
       (end-of-buffer)
      (eval-print-last-sexp)))))
(require 'el-get)

;; 起動時にインストールしてあるelispをアップデートする
(el-get 'sync)



;;自動補完モード
;(define-key ac-complete-mode-map "\C-n" 'ac-next)
;(define-key ac-complete-mode-map "\C-p" 'ac-previous)


(el-get 'sync '(auto-complete-clang))
(require 'auto-complete)
(require 'auto-complete-config)
(require 'auto-complete-clang)
(global-auto-complete-mode t)
(setq ac-auto-start t)
(add-hook 'auto-complete-mode-hook
          (lambda ()
         (define-key ac-completing-map (kbd "C-n") 'ac-next)
          (define-key ac-completing-map (kbd "C-p") 'ac-previous)))

(el-get 'sync '(go-mode))



;;htmlの入力補助？動かしてない
(el-get 'sync '(zencoding-mode))
;(require 'zencoding-mode nil t)

;;undoを視覚化
(el-get 'sync '(undo-tree))
(when (require 'undo-tree nil t)
  (global-undo-tree-mode))

;;emacsをタブ化
(el-get 'sync '(tabbar))

;;anythingのフォーク版、今は動かしてない
(el-get 'sync '(helm))

;;phpのメジャーモードを実現
(el-get 'sync '(php-mode-improved))
(add-to-list 'auto-mode-alist '("\\.php$" . php-mode))

;;git管理に必要なmagit
(el-get 'sync '(magit))
(when (executable-find "git")
      (require 'magit nil t))




;;全角、半角スペースを表示
;;(defface my-face-b-1 '((t (:background "medium aquamarine"))) nil)
;;(defface my-face-b-1 '((t (:background "dark turquoise"))) nil)
;;(defface my-face-b-2 '((t (:background "cyan"))) nil)
;;(defface my-face-b-2 '((t (:background "SeaGreen"))) nil)
;;(defface my-face-u-1 '((t (:foreground "SteelBlue" :underline t))) nil)
;;(defvar my-face-b-1 'my-face-b-1)
;;(defvar my-face-b-2 'my-face-b-2)
;;(defvar my-face-u-1 'my-face-u-1)
;;(defadvice font-lock-mode (before my-font-lock-mode ())
;;(font-lock-add-keywords
;;major-mode
;;'(
;;("　" 0 my-face-b-1 append)
;;("\t" 0 my-face-b-2 append)
;;("[ ]+$" 0 my-face-u-1 append)
;;)))
;;(ad-enable-advice 'font-lock-mode 'before 'my-font-lock-mode)
;;(ad-activate 'font-lock-mode)
;;(add-hook 'find-file-hooks '(lambda ()
;;(if font-lock-mode
;;nil
;;(font-lock-mode t))))



1(setq pc-select-selection-keys-only t)
;(pc-selection-mode 1)


;何か履歴を次回emacs起動時にも保存するらしい
(savehist-mode 1)

;最後のデスクトップの状態を保存して次回起動時に反映させる
;(desktop-save-mode 1)


;;バッファを自動再読み込み
(global-auto-revert-mode 1)


;;既定のブラウザをchromeに
(setq browse-url-browser-function 'browse-url-generic)
(setq browse-url-generic-program
(if (file-exists-p "/usr/bin/open")
"/usr/bin/open"))



;; 新規ファイルの属するディレクトリがなかった場合は作成する
(defadvice find-file (before make-directory-maybe (filename &optional wildcards) activate)
  "Create parent directory if not exists while visiting file."
  (unless (file-exists-p filename)
    (let ((dir (file-name-directory filename)))
      (unless (file-exists-p dir)
        (make-directory dir t)))))

