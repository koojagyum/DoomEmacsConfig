;;; koodev/+claude.el -*- lexical-binding: t; -*-

;; claude-code.el integration. The package is declared in packages.el
;; from a GitHub recipe; the :term vterm Doom module satisfies the
;; terminal backend.
(use-package! claude-code
  :defer t
  :custom
  (claude-code-terminal-backend 'vterm))

;;; +claude.el ends here
