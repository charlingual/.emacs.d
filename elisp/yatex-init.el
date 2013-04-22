;; YaTeX-mode
(setq auto-mode-alist
      (cons (cons "\\.tex$" 'yatex-mode) auto-mode-alist))
(autoload 'yatex-mode "yatex" "Yet Another LaTeX mode" t)



(setq tex-command "~/Library/TeXShop/bin/platex2pdf-utf8"
      dvi2-command "open -a Preview"
      ;tex-command "platex"
      section-name "documentclass"
      makeindex-command "mendex"
      YaTeX-use-AMS-LaTeX t
      YaTeX-use-LaTeX2e t
      YaTeX-use-font-lock t
      ;dviprint-command-format "dvips %s | lpr"
      YaTeX-kanji-code 4)

;; YaHtml-mode
(setq auto-mode-alist
      (cons (cons "\\.html$" 'yahtml-mode) auto-mode-alist))
(autoload 'yahtml-mode "yahtml" "Yet Another HTML mode" t)
(setq yahtml-www-browser "netscape")

(setq mac-option-modifier 'meta)

(setq indent-tabs-mode nil)


;(setq tex-command "~/Library/TeXShop/bin/platex2pdf-utf8"
;      ;dvi2-command "open -a Preview"
;      YaTeX-kanji-code 4
;      section-name "documentclass"
;      makeindex-command "mendex"
;      YaTeX-use-AMS-LaTeX t
;      YaTeX-use-LaTeX2e t
;      YaTeX-use-font-lock t
;      )

;; previewにtexshop
;(setq tex-command "~/Library/TeXShop/bin/platex2pdf-euc"
;       dvi2-command "open -a TeXShop")


;(setq tex-command "platex"
;      dvi2-command "dviout -1 -Set=!m"
;      YaTeX-kanji-code 3 ;
;      YaTeX-latex-message-code 'sjis 
;      section-name "documentclass"
;      makeindex-command "mendex"
;      YaTeX-use-AMS-LaTeX t 
;      YaTeX-use-LaTeX2e t  
;      YaTeX-use-font-lock t 
;      )
;(add-hook 'yatex-mode-hook'
;  (lambda ()(setq auto-fill-function nil)))
