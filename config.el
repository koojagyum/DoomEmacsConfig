;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

;; Doom variables — top-level setting is endorsed by the default template
;; (see comment block in static/config.example.el upstream).
(setq doom-theme 'doom-solarized-dark
      display-line-numbers-type t
      org-directory "~/org/")

;; User-local config files. `load!' is the canonical Doom way to pull in
;; sibling .el files relative to $DOOMDIR.
(load! "koodev/+util")
(load! "koodev/+editor")
(load! "koodev/+bindings")
(load! "koodev/+org")
(load! "koodev/+claude")

;; Per-machine overrides (e.g. sourcekit-lsp path, secrets). Optional —
;; the third argument tells `load!' to stay quiet if the file is missing.
(load! "local" nil t)
