DISABLE_AUTO_TITLE="true"
eval $(/opt/homebrew/bin/brew shellenv)
eval "$(sheldon source)"


: "一般的な設定" && {
  setopt correct # 入力しているコマンド名が間違っている場合にもしかして：を出す。
  setopt nobeep # ビープを鳴らさない
  setopt no_tify # バックグラウンドジョブが終了したらすぐに知らせる。

  setopt auto_pushd # cd -[tab]で過去のディレクトリにひとっ飛びできるようにする
  setopt pushd_ignore_dups # 同じディレクトリを pushd しない
  setopt auto_cd # ディレクトリ名を入力するだけでcdできるようにする
  setopt interactive_comments # コマンドラインでも # 以降をコメントと見なす

  setopt print_eight_bit # 日本語ファイル名を表示可能にする

  setopt chase_links # シンボリックリンクは実体を追う
}

: "ヒストリ関連の設定" && {
    HISTFILE=$HOME/.zsh_history # ヒストリファイル名
    HISTSIZE=1000000000                   # メモリ内の履歴の数
    SAVEHIST=1000000000                   # 保存される履歴の数
    setopt extended_history               # 履歴ファイルに時刻を記録
    setopt append_history        # 履歴を追加 (毎回 .zsh_history を作るのではなく)
    setopt hist_ignore_dups # 直前と同じコマンドをヒストリに追加しない
    setopt hist_ignore_all_dups # 重複するコマンドは古い法を削除する
    setopt share_history # 異なるウィンドウでコマンドヒストリを共有する
    setopt hist_no_store # historyコマンドは履歴に登録しない
    setopt hist_reduce_blanks # 余分な空白は詰めて記録
    setopt hist_verify # `!!`を実行したときにいきなり実行せずコマンドを見せる
}

: "プロンプトの設定" && {
    autoload -Uz vcs_info
    autoload -U colors && colors
    setopt prompt_subst

    zstyle ':vcs_info:git:*' check-for-changes true #formats 設定項目で %c,%u が使用可
    zstyle ':vcs_info:git:*' stagedstr "%F{yellow}!" #commit されていないファイルがある
    zstyle ':vcs_info:git:*' unstagedstr "%F{red}+" #add されていないファイルがある
    zstyle ':vcs_info:*' formats "%F{cyan}%c%u(%b)%f" #通常
    zstyle ':vcs_info:*' actionformats '[%b|%a]' #rebase 途中,merge コンフリクト等 formats 外の表示
    precmd () { vcs_info }

    export PS_BOLD="%{[1m%}"
    export PS_RESET="%{[0m%}"

    triangle=$'\uE0B0' # 三角矢印

    PS_FG_AROW1="%{[38;5;54m%}"
    PS_BG_AROW1="%{[48;5;235m%}"
    arrow1="${PS_BG_AROW1}${PS_FG_AROW1}${triangle}"

    PS_FG_AROW2="%{[38;5;235m%}"
    PS_BG_AROW2="%{[48;5;0m%}"
    arrow2="${PS_BG_AROW2}${PS_FG_AROW2}${triangle}"
    PS_FG_AROW2E="%{[38;5;235m%}"
    PS_BG_AROW2E="%{[48;5;160m%}"
    arrow2e="${PS_BG_AROW2E}${PS_FG_AROW2E}${triangle}"

    PS_FG_AROW3="%{[38;5;160m%}"
    PS_BG_AROW3="%{[48;5;0m%}"
    arrow3="${PS_BG_AROW3}${PS_FG_AROW3}${triangle}"

    PS_FG_USER="%{[38;5;206m%}"
    PS_BG_USER="%{[48;5;235m%}"

    PS_FG_DELIMITA="%{[38;5;165m%}"
    PS_BG_DELIMITA="%{[48;5;235m%}"

    PS_FG_HOST="%{[38;5;206m%}"
    PS_BG_HOST="%{[48;5;235m%}"

    PS_FG_DATE="%{[38;5;250m%}"
    PS_BG_DATE="%{[48;5;54m%}"

    PS_FG_ERR="%{[38;5;11m%}"
    PS_BG_ERR="%{[48;5;160m%}"

    PS_USER="${PS_BG_USER}${PS_FG_USER}%n${PS_RESET}"
    PS_USER_HOST_DELIMITER="${PS_BG_DELIMITA}${PS_FG_DELIMITA}@${PS_RESET}"
    PS_HOST="${PS_BG_HOST}${PS_FG_HOST}%m${PS_RESET}"
    PS_TIME="${PS_BOLD}${PS_BG_DATE}${PS_FG_DATE}%*${arrow1} ${PS_RESET}"
    PS_ERRSTAT="%(?,${arrow2} ,${arrow2e}${PS_BOLD}${PS_BG_ERR}${PS_FG_ERR}[%?]${arrow3} )${PS_RESET}"
    PS_PROMPT_MARK="%F{yellow}%#%f"

    PROMPT='${PS_TIME}${PS_USER}${PS_USER_HOST_DELIMITER}${PS_HOST}${PS_ERRSTAT}${PS_PROMPT_MARK} '
    RPROMPT='${vcs_info_msg_0_} %{$fg[yellow]%}%~%{$reset_color%}'
}

: "補完機能の設定" && {
    autoload -Uz compinit && compinit # 補完機能の強化

    setopt magic_equal_subst # = 以降でも補完できるようにする( --prefix=/usr 等の場合)
    setopt auto_list # 補完候補を一覧表示
    setopt auto_menu # TAB で順に補完候補を切り替える
    #unsetopt auto_menu # タブによるファイルの順番切り替えをしない
    setopt list_types # 補完候補一覧でファイルの種別をマーク表示
    zstyle ':completion:*:default' menu select=1 # 補完候補のカーソル選択を有効に(C-f C-b C-p C-nとかでも移動できる)
    setopt list_packed # 補完候補を詰めて表示

    # source /usr/local/share/zsh/site-functions/_aws # awsコマンドの補完

    export LSCOLORS="Gxfxcxdxbxegedabagacad"

    # 補完時の色の設定
    export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
    # ZLS_COLORSとは？
    export ZLS_COLORS=$LS_COLORS
    # lsコマンド時、自動で色がつく(ls -Gのようなもの？)
    export CLICOLOR=true
    # 補完候補に色を付ける
    zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

    # killコマンドをプロセス名から補完する
    # See: https://qiita.com/mollifier/items/33bda290fe3c0ae7b3bb
    zstyle ':completion:*:processes' command "ps aux"
    zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
}


: "anyframeの設定" && {
    zstyle ":anyframe:selector:" use fzf
    zstyle ":anyframe:selector:fzf:" command 'fzf --extended --select-1 --ansi --exit-0 --no-sort'
    zstyle ':filter-select' case-insensitive yes

    : "anyframeのキーバインド" && {
          bindkey '^r' anyframe-widget-put-history

          bindkey '^xb' anyframe-widget-cdr
          bindkey '^x^b' anyframe-widget-checkout-git-branch

          bindkey '^xr' anyframe-widget-put-history
          bindkey '^x^r' anyframe-widget-put-history

          bindkey '^xi' anyframe-widget-put-history
          bindkey '^x^i' anyframe-widget-put-history

          bindkey '^xg' anyframe-widget-cd-ghq-repository
          bindkey '^x^g' anyframe-widget-cd-ghq-repository

          bindkey '^xk' anyframe-widget-kill
          bindkey '^x^k' anyframe-widget-kill

          bindkey '^xe' anyframe-widget-insert-git-branch
          bindkey '^x^e' anyframe-widget-insert-git-branch
      }
}


: "キーバインディング" && {
  bindkey -e # emacs キーマップを選択

  : "Ctrl-Yで上のディレクトリに移動できる" && {
    function cd-up { zle push-line && LBUFFER='builtin cd ..' && zle accept-line }
    zle -N cd-up

    bindkey "^x^y" cd-up
  }

  : "Ctrl-Dでシェルからログアウトしない" && {
    setopt ignoreeof
  }

  : "Ctrl-Wでパスの文字列などをスラッシュ単位でdeleteできる" && {
    autoload -U select-word-style
    select-word-style bash
  }

  : "Ctrl-[で直前コマンドの単語を挿入できる" && {
    autoload -Uz smart-insert-last-word
    zstyle :insert-last-word match '*([[:alpha:]/\\]?|?[[:alpha:]/\\])*' # [a-zA-Z], /, \ のうち少なくとも1文字を含む長さ2以上の単語
    zle -N insert-last-word smart-insert-last-word
    bindkey '^[' insert-last-word
    # see http://qiita.com/mollifier/items/1a9126b2200bcbaf515f
  }
}


: "cd先のディレクトリのファイル一覧を表示する" && {
  [ -z "$ENHANCD_ROOT" ] && function chpwd { ls -lah } # enhancdがない場合
  [ -z "$ENHANCD_ROOT" ] || export ENHANCD_HOOK_AFTER_CD="ls -lah" # enhancdがあるときはそのHook機構を使う
}


: "sshコマンド補完を~/.ssh/configから行う" && {
  function _ssh { compadd `fgrep 'Host ' ~/.ssh/config.* | grep -v '*' |  awk '{print $2}' | sort` }
}

: "aliasの設定" && {
    alias mv="mv -iv" # mv時、移動先に同名ファイルがあった場合上書き確認を出す
    alias ls="ls -laG"
    alias tmux="tmux -2"
    alias ssh='TERM=xterm ssh'
    alias history='fc -l'
    alias h='history -10'
    alias hist='history -100'
    alias duc='du | sort -nr | head -10'
    alias ta='task add'
    alias reload='exec zsh -l'

    alias tn='task next'
    alias t='task'
    alias envsudo="sudo env PATH=$PATH"

    # export PATH="/usr/local/sbin:$PATH"

#    alias brew="env PATH=${PATH/\/Users\/***REMOVED***\/\.anyenv\/envs\/pyenv\/shims:/} brew"

    alias procport="lsof -nPi"
    alias slackcat2***REMOVED***="slackcat --channel ***REMOVED***:***REMOVED*** --tee"
    alias tree="tree -N"

    alias dl=wget --content-disposition

    alias grep='grep --color=auto'
    alias cgrep="grep --color=always"

    alias cdpython='cd ~/workspace/python'
    alias cdsbt='cd ~/workspace/sbt'
    alias cdgithub='cd ~/workspace/github'
}

: "ssh-agentを使用してssh認証を保持する" && {
    if [ -e ${HOME}/.ssh-agent-info ]; then
        source ${HOME}/.ssh-agent-info
    fi

    ssh-add -l >&/dev/null
    if [ $? = 2 ] ; then
        echo -n "ssh-agent: restart...."
        ssh-agent > ${HOME}/.ssh-agent-info
        source ${HOME}/.ssh-agent-info
    fi

    if ssh-add -l >&/dev/null ; then
        echo "ssh-agent: Identity is already stored."
    else
        ssh-add
    fi
}



td() { task $1 done; }
docker-clear-containers() { docker rm $(docker ps -a -q) }
docker-delete-exited() { docker rm $(docker ps -a --filter 'status=exited' -q) }
bitrwx() { echo "obase=8; ibase=2; $1" | bc }
gi() { curl -sL https://www.gitignore.io/api/$@ ;}
whouseport() { lsof -n -P -i :$@ ;}

paste-as-yank() {
  PASTE=$(pbpaste)
  LBUFFER="$LBUFFER${RBUFFER:0:1}"
  RBUFFER="$PASTE${RBUFFER:1:${#RBUFFER}}"
}
zle -N paste-as-yank
bindkey "^y" paste-as-yank


##
## 環境変数の設定
##
stty erase "^H"

export LANG=ja_JP.UTF-8

export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_STATE_HOME="${HOME}/.local/state"

export PIPENV_VENV_IN_PROJECT=true
export MYSQL_PS1="[\R:\m:\s \u@mysql://`hostname`/\d] > "

export PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true
export PUPPETEER_EXECUTABLE_PATH=`which chromium`

# ${HOME}/binディレクトリへのパスを通す
# ユーザー固有実行バイナリやシェルスクリプトなどを置く場所
export PATH="$HOME/bin:$PATH"

# poetry
export PATH="$HOME/.local/bin:$PATH"

# brewで入れたmysqlコマンドのパスを通す
export PATH="/opt/homebrew/opt/mysql-client/bin:$PATH"

# rust/cargo
export PATH="$HOME/.cargo/bin:$PATH"
source $HOME/.cargo/env

# go
export GOPATH=$HOME/.go
export PATH=$PATH:$HOME/.go/binexport PATH="/opt/homebrew/opt/node@18/bin:$PATH"

# nodejs by homebrew
export PATH="/opt/homebrew/opt/node@18/bin:$PATH"
