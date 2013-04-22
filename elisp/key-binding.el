
;;macのキーバインドを実現
;(require 'mac-key-mode)
;(mac-key-mode 1)

;;optionをメタキーに
(setq mac-option-modifier 'meta)

;;コントロールキーをemacsの方に渡す
(setq mac-pass-control-to-system t)


(global-set-key (kbd "C-t") 'next-multiframe-window)


;;command-keyをsuperに変更
(setq mac-command-modifier 'super)

;; キーバインドをエイリアスするマクロ
(defmacro kbd-macro-alias (akey bkey)
  (declare (indent 1))
  `(global-unset-key (kbd ,akey))
  `(global-set-key (kbd ,akey)
                   (lambda ()
                     (interactive)
                     (execute-kbd-macro (kbd ,bkey)))))


(kbd-macro-alias "s-c" "M-w")
(kbd-macro-alias "s-v" "C-y")
(kbd-macro-alias "s-x" "C-w")

;;undo
(define-key global-map (kbd "s-z") 'undo)
