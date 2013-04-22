
;;mac�̃L�[�o�C���h������
;(require 'mac-key-mode)
;(mac-key-mode 1)

;;option�����^�L�[��
(setq mac-option-modifier 'meta)

;;�R���g���[���L�[��emacs�̕��ɓn��
(setq mac-pass-control-to-system t)


(global-set-key (kbd "C-t") 'next-multiframe-window)


;;command-key��super�ɕύX
(setq mac-command-modifier 'super)

;; �L�[�o�C���h���G�C���A�X����}�N��
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
