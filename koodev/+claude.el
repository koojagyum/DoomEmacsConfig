;;; koodev/+claude.el -*- lexical-binding: t; -*-

(use-package! claude-code-ide
  :defer t
  :config
  ;; Eanble Emacs MCP
  (claude-code-ide-emacs-tools-setup)
  ;; Terminal backend
  (setq claude-code-ide-terminal-backend 'vterm)
  ;; Window location and size
  (setq claude-code-ide-window-side 'bottom))

;;; +claude.el ends here
