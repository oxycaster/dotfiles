# dotfiles

oxycasterが使うdotfilesを管理する


## Pre-requirements

```bash
brew bundle
brew install sheldon
```

## Brewfileの更新

```shell
brew bundle dump
cp -i -R Brewfile brew/Brewfile
```