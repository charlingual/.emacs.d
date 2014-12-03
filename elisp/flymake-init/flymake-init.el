(require 'flymake)

(defun flymake-cc-init ()
  (let* ((temp-file   (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-inplace))
         (local-file  (file-relative-name
                       temp-file
                       (file-name-directory buffer-file-name))))
    (list "g++" (list "-Wall" "-Wextra"
		      "-fsyntax-only" local-file))))

(push '("\\.cpp$" flymake-cc-init) flymake-allowed-file-name-masks)


(defun flymake-c-init ()
  (let* ((temp-file  (flymake-init-create-temp-buffer-copy
                     'flymake-create-temp-inplace))
         (local-file (file-relative-name
                      temp-file
                      (file-name-directory buffer-file-name))))
    (list "gcc" (list "-Wall" "-W" ;"-pedantic"
		      "-fsyntax-only"
		      local-file))))
(push '("\\.c$" flymake-c-init) flymake-allowed-file-name-masks)


(defun flymake-ruby-init ()
  (let* ((temp-file   (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-inplace))
         (local-file  (file-relative-name
                       temp-file
                       (file-name-directory buffer-file-name))))
    (list "ruby" (list "-c" local-file))))
(push '(".+\\.rb$" flymake-ruby-init) flymake-allowed-file-name-masks)
(push '("Rakefile$" flymake-ruby-init) flymake-allowed-file-name-masks)
(push '("^\\(.*\\):\\([0-9]+\\): \\(.*\\)$" 1 2 nil 3) flymake-err-line-patterns)


(defun flymake-pyflakes-init ()
  (let* ((temp-file (flymake-init-create-temp-buffer-copy
                     'flymake-create-temp-inplace))
         (local-file (file-relative-name
                      temp-file
                      (file-name-directory buffer-file-name))))
    (list "pyflakes" (list local-file))))
(add-to-list 'flymake-allowed-file-name-masks
	     '("\\.py\\'" flymake-pyflakes-init))


;; flymake
(defun flymake-php-init ()
  (let* ((temp-file (flymake-init-create-temp-buffer-copy
                     'flymake-create-temp-inplace))
         (local-file (file-relative-name
                      temp-file
                      (file-name-directory buffer-file-name))))
    (list "php" (list "-l" local-file))))
(push '(".+\\.php$" flymake-php-init) flymake-allowed-file-name-masks)
(push '("(Parse|Fatal) error: (.*) in (.*) on line ([0-9]+)" 3 4 nil 2) flymake-err-line-patterns)

(add-hook 'php-mode-hook (flymake-mode t))




;;ここからHaskell用
(defun flymake-haskell-make-command (temp-file)
  (list "make"
        (flymake-haskell-make-parameters temp-file)))

(defun flymake-haskell-make-parameters (temp-file)
  (list "-s"
        "-C"
        "."
        (concat "CHK_SOURCES=" temp-file)
        "SYNTAX_CHECK_MODE=1"
        "check-syntax"))

(defun flymake-haskell-default-ghc-command (local-file)
  (list "ghc"
        (flymake-haskell-default-ghc-parameters
          (file-name-nondirectory local-file))))

(defun flymake-haskell-default-ghc-parameters (local-file)
  (list "-fno-code" local-file))

(defun makefile-exists-p (path)
  (file-exists-p (concat path "Makefile")))

(defun flymake-haskell-init()
  (let* ((temp-file  (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-inplace))
         (local-file (file-relative-name
                       temp-file
                       (file-name-directory buffer-file-name))))
    (if (makefile-exists-p (file-name-directory buffer-file-name))
        (flymake-haskell-make-command temp-file)
        (flymake-haskell-default-ghc-command local-file))))

(push '(".+\\hs$" flymake-haskell-init) flymake-allowed-file-name-masks)
(push '(".+\\lhs$" flymake-haskell-init) flymake-allowed-file-name-masks)
(push '("^\\(\.+\.hs\\|\.lhs\\):\\([0-9]+\\):\\([0-9]+\\):\\(\.+\\)" 1 2 3 4)
      flymake-err-line-patterns)

(add-hook 'haskell-mode-hook
    '(lambda ()
       (if (not (null buffer-file-name))
           (flymake-mode))))


 ;;;; HTML
  ;;(when (executable-find "tidy")
  ;;  (defun flymake-html-init ()
  ;;    (let* ((coding (coding-system-base buffer-file-coding-system))
  ;;	     (opt (cdr (assq coding
  ;;			     '((utf-8 . "-utf8")
  ;;			       (iso-2022-jp . "-iso2022")
  ;;			       (japanese-shift-jis . "-shiftjis"))))))
  ;;	(flymake-simple-generic-init
  ;;	 "tidy" (list "-e" opt))))
  ;;
  ;;  (push '("\\.html\\'\\|\\.ctp" flymake-html-init) flymake-allowed-file-name-masks)
  ;;  (push '("line \\([0-9]+\\) column \\([0-9]+\\) - \\(Warning\\|Error\\): \\(.*\\)" nil 1 2 4) flymake-err-line-patterns)
  ;;  )

  ;;;; XSL
  ;;(push '(".+\\.xsl\\'" flymake-xml-init) flymake-allowed-file-name-masks)

  ;;;; Python
  ;;(defun flymake-pep8-init ()
  ;;  (flymake-simple-generic-init
  ;;   "pep8"))
  ;;
  ;;(defun flymake-pylint-init ()
  ;;  (flymake-simple-generic-init
  ;;   "epylint"))
  ;;
  ;;(push '("\\.py\\'" flymake-pylint-init) flymake-allowed-file-name-masks)
  ;;(push '("\\.py\\'" flymake-pep8-init) flymake-allowed-file-name-masks)

  ;;;; Javascript
  ;;(defun flymake-js-init ()
  ;;  (flymake-simple-generic-init
  ;;   "js" '("-s")))
  ;;
  ;;(push '(".+\\.json\\'" flymake-js-init) flymake-allowed-file-name-masks)
  ;;(push '(".+\\.js\\'" flymake-js-init) flymake-allowed-file-name-masks)
  ;;
  ;;(push '("^\\(.+\\)\:\\([0-9]+\\)\: \\(strict warning: trailing comma.+\\)\:$" 1 2 nil 3)
  ;;	flymake-err-line-patterns)



;;文法エラー箇所に飛ぶ
(global-set-key "\M-p" 'flymake-goto-prev-error)
(global-set-key "\M-n" 'flymake-goto-next-error)
;;構文チェックを開始する
(global-set-key "\C-cc" 'flymake-start-syntax-check)



(set (make-local-variable 'post-command-hook)
     (add-hook 'post-command-hook 'flymake-popup-err-message))
;(global-set-key "\C-cd" 'flymake-popup-err-message)

;(add-hook 'c-mode-hook
;         '(lambda ()
;             (flymake-mode t)))
(add-hook 'find-file-hook 'flymake-find-file-hook);;全部のファイルに適用
;;flymake落ちても無視するらしい
(defadvice flymake-post-syntax-check (before flymake-force-check-was-interrupted)
  (setq flymake-check-was-interrupted t))
(ad-activate 'flymake-post-syntax-check)

;;guiの警告を無視
(setq flymake-gui-warnings-enabled nil)


;;ポップアップ関係らしい
;;(defun flymake-popup-err-message ()
;;  "Display a menu with errors/warnings for current line if it has errors and/or warnings."
;;  (interactive)
;;  (let* ((line-no            (flymake-current-line-no))
;;         (line-err-info-list (nth 0 (flymake-find-err-info flymake-err-info line-no)))
;;         (menu-data          (flymake-make-err-menu-data line-no line-err-info-list)))
;;    (if menu-data
;;      (popup-tip (mapconcat '(lambda (e) (nth 0 e))
;;                            (nth 1 menu-data)
;;                            "\n")))
;;    ))



