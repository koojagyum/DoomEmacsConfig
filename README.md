Doom Emacs Config
--

## Requirement

* Emacs: `emacs-mac@29`
* doomemacs: 260419 or later

## Install

Install Emacs

```shell
$ brew tap railwaycat/emacsmacport
$ brew install emacs-mac --with-modules
$ ln -s /opt/homebrew/opt/emacs-mac/Emacs.app /Applications/Emacs.app
```

Setup Doom Emacs

```shell
$ rm -rf ~/.emacs.d
$ git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.config/emacs
$ git clone https://github.com/koojagyum/DoomEmacsConfig.git ~/.config/doom
$ ~/.config/emacs/bin/doom install
```
