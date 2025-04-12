#!/usr/bin/env bash

# ~/.configディレクトリに設定系はまとめようという取り決め仕様がある
# XDG Base Directory (Spec: https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html )
XDG_CONFIG_HOME="${HOME}/.config"

SCRIPT_DIR=$(cd $(dirname $0); pwd)


ln -isvn "${SCRIPT_DIR}/brew/Brewfile" "${HOME}/Brewfile"

# lnコマンドに付与しているオプション
# i = 上書き前に確認する
# s = ハードリンクの代わりにシンボリックリンクを作成する
# v = 作業の詳細を表示する
# n = リンクの作成場所として指定したディレクトリがシンボリックリンクだった場合、参照先にリンクを作るのではなくシンボリックリンクそのものを置き換える（-fと組み合わせて使用）
mkdir -p "${XDG_CONFIG_HOME}/sheldon"
ln -isvn "${SCRIPT_DIR}/sheldon/plugins.toml" "${XDG_CONFIG_HOME}/sheldon/plugins.toml"


mkdir -p "${XDG_CONFIG_HOME}/zsh"
ln -isvn "${SCRIPT_DIR}/zsh/.zshenv" "${HOME}/.zshenv"
ln -isvn "${SCRIPT_DIR}/zsh/.zshrc" "${XDG_CONFIG_HOME}/zsh/.zshrc"

mkdir -p "${XDG_CONFIG_HOME}/bash"
ln -isvn "${SCRIPT_DIR}/bash/bashrc" "${HOME}/.bashrc"

mkdir -p "${XDG_CONFIG_HOME}/git"
ln -isvn "${SCRIPT_DIR}/git/config.gitconfig" "${XDG_CONFIG_HOME}/git/config"
ln -isvn "${SCRIPT_DIR}/git/ignore.gitignore" "${XDG_CONFIG_HOME}/git/ignore"

ln -isvn "${SCRIPT_DIR}/starship/starship.toml" "${XDG_CONFIG_HOME}/starship.toml"

mkdir -p "${XDG_CONFIG_HOME}/wezterm"
ln -isvn "${SCRIPT_DIR}/wezterm/wezterm.lua" "${XDG_CONFIG_HOME}/wezterm/wezterm.lua"