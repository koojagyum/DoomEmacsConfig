;;; koodev/+editor.el -*- lexical-binding: t; -*-

;; System clipboard integration (modern variable name; the legacy
;; `x-select-enable-clipboard' is now an alias for this).
(setq select-enable-clipboard t)

;; Spell out yes/no — we'd rather miss a keystroke than commit a typo.
(setq use-short-answers nil)

;; Default font
(setq doom-font (font-spec :family "Menlo" :size 12))

;; Korean (Hangul) input via Emacs' built-in IME.
(setq default-input-method "korean-hangul")

;; Map the Hangul block (U+1100..U+FFDC) to AppleGothic. Hangul glyphs
;; render small relative to Latin in Monaco, so scale them up 1.2x.
(set-fontset-font "fontset-default" '(#x1100 . #xffdc)
                  '("AppleGothic" . "unicode-bmp"))
(setq face-font-rescale-alist '(("AppleGothic" . 1.2)))

;;; +editor.el ends here
