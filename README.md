Doom Emacs Config
--

## Requirement

* Emacs: `emacs-mac`
* doomemacs: 260419 or later

## Install

Install Emacs

```shell
$ brew tap railwaycat/emacsmacport
$ brew install emacs-mac --with-modules
$ brew install ripgrep
$ brew install cmake
$ brew install libvterm
$ ln -s /opt/homebrew/opt/emacs-mac/Emacs.app /Applications/Emacs.app
```

Setup Doom Emacs

```shell
$ rm -rf ~/.emacs.d
$ git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.config/emacs
$ git clone https://github.com/koojagyum/DoomEmacsConfig.git ~/.config/doom
$ ~/.config/emacs/bin/doom install
```

Setup .zshrc

```shell
alias emacs='/opt/homebrew/opt/emacs-mac/bin/emacs -nw'

export PATH="$HOME/.config/emacs/bin:$PATH"
```
