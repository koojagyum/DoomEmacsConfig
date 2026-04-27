;;; koodev/+claude.el -*- lexical-binding: t; -*-

(use-package! claude-code-ide
  :defer t
  :config
  ;; Eanble Emacs MCP
  (claude-code-ide-emacs-tools-setup)
  ;; Terminal backend
  (setq claude-code-ide-terminal-backend 'vterm))

;;; +claude.el ends here
