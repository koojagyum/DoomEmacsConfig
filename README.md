Doom Emacs Config
--

## Requirement

* Emacs: `emacs-mac@30exp`
* doomemacs: 260419 or later

## Install

Install Emacs

```shell
$ brew tap railwaycat/emacsmacport
$ brew install emacs-mac@30exp --with-modules
$ ln -s /opt/homebrew/opt/emacs-mac@30exp/Emacs.app /Applications/Emacs.app
```

Setup Doom Emacs

```shell
$ rm -rf ~/.emacs.d
$ git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.config/emacs
$ git clone https://github.com/koojagyum/DoomEmacsConfig.git ~/.config/doom
$ ~/.config/emacs/bin/doom install
```

Setup .zshrc

``` shell
alias emacs='/opt/homebrew/opt/emacs-mac@30exp/bin/emacs -nw'

export PATH="$HOME/.config/emacs/bin:$PATH"
```
