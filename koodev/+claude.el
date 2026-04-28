;;; koodev/+claude.el -*- lexical-binding: t; -*-

(use-package! claude-code-ide
  :defer t
  :config
  ;; Eanble Emacs MCP
  (claude-code-ide-emacs-tools-setup)
  ;; Enable NO_FLICKER mode
  (setenv "CLAUDE_CODE_NO_FLICKER" "1")
  ;; Terminal backend
  (setq claude-code-ide-terminal-backend 'vterm)
  ;; Window location and size
  (setq claude-code-ide-window-side 'bottom))

;;; +claude.el ends here
