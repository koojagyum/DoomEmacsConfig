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

;; Display table for vterm
(after! vterm
  (defun my/vterm-fix-claude-glyphs ()
    "Replace problematic glypes in Claude Code vterm buffers with
visually similar but width-stable alternatives. This avoids font
fallback for glyphs missing from Menlo (U+23FA, U+273D, etc.)."
    (let ((dt (or buffer-display-table (make-display-table))))
      ;; ⏺ (U+23FA BLACK CIRCLE FOR RECORD) -> ● (U+25CF BLACK CIRCLE)
      ;; Claude uses ⏺ for tool execution markers; ● is visually identical
      ;; but it ni Menlo's monospace coverage, ensuring stable width
      (aset dt #x23FA (vector (make-glyph-code ?●)))
      ;; ✽ (U+273D HEAVY TEARDROP-SPOKED ASTERISK) -> ✻ (U+273B TEARDROP-SPOKED ASTERISK)
      ;; ✻ has stable width in Menlo; ✽ does not.
      (aset dt #x273D (vector (make-glyph-code ?✽)))

      (setq buffer-display-table dt)))

  (add-hook 'vterm-mode-hook #'my/vterm-fix-claude-glyphs))

;;; +editor.el ends here
