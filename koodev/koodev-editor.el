;;; koodev/koodev-editor.el -*- lexical-binding: t; -*-

(setq display-line-numbers-type t)

;;; My private setting
;; Hangul setting
(setq default-input-method "korean-hangul")
(setq doom-font (font-spec :family "Monaco" :size 12))

(set-fontset-font "fontset-default" '(#x1100 . #xffdc)
                  '("AppleGothic" . "unicode-bmp"))
(setq face-font-rescale-alist '(("AppleGothic" . 1.2)))

;; Enable copying to clipboard (make a region is to copy...)
(setq x-select-enable-clibboard t)

;; Disable short answer
(setq use-short-answers nil)

;; theme
(setq doom-theme 'doom-solarized-light)

(provide 'koodev-editor)

;;; koodev-editor.el ends here
