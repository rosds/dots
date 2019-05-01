# Dot files

Clone as bare

```sh
git clone --bare --branch dots git@github.com:alfonsoros88/dots.git $HOME/.dots.git
```

Setup alias

```sh
alias dots="/usr/bin/git --git-dir=$HOME/.dots.git/ --work-tree=$HOME"
```


