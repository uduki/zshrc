export LANG=ja_JP.UTF-8
HISTFILE=$HOME/.zsh-history
HISTSIZE=100000
SAVEHIST=100000

## 補完機能の強化
autoload -U compinit
compinit
#autoload predict-on
#predict-on

## プロンプトの設定はここへ
case ${UID} in
0)
    ## root
    BASE="%n@%M%B%{[31m%}#%{[m%}%b "
    LOCATION="%B%{[31m%}[%{[m%}%b%/%B%{[31m%}]%{[m%}%b"$'\n'
    ;;
*)
    ## user
    BASE="%n@%M> "
    LOCATION="%B%{[31m%}[%{[m%}%b%/%B%{[31m%}]%{[m%}%b"$'\n'
    ;;
esac
PROMPT=${LOCATION}${BASE}
PROMPT2=${LOCATION}"%_:"${BASE}
SPROMPT="%r is correct? [n,y,a,e]:"
[ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && PROMPT="${LOCATION}${BASE}"

## タイトル設定
case "${TERM}" in
kterm*|xterm)
    precmd(){
#       echo -ne "\033]0;${USER}@${HOST%%.*}:${PWD}\007"
        echo -ne "\033]0;${PWD}\007"
    }
    ;;
*)
    precmd(){
        echo -ne ""
    }
    ;;
esac

## コアダンプサイズを制限
limit coredumpsize 102400

## 出力の文字列末尾に改行コードが無い場合でも表示
unsetopt promptcr

## 色を使う
setopt prompt_subst

## ビープを鳴らさない
setopt nobeep

## 内部コマンドjobsの出力をデフォルトでjobs -lにする
setopt long_list_jobs

## emacs キーバインド
bindkey -e

## 補完候補一覧でファイルの種別をマーク表示
setopt list_types

## サスペンド中のプロセスと同じコマンド名を実行した場合はレジューム
setopt auto_resume

## 補完候補を一覧表示
setopt auto_list

## 補完候補を詰めて表示
setopt list_packed

## 直前と同じコマンドをヒストリに追加しない
setopt hist_ignore_dups

## cd時に自動でpush
setopt autopushd

## 同じディレクトリをpushdしない
setopt pushd_ignore_dups

## ファイル名で#,~,^の3文字を正規表現として扱う
setopt extended_glob

## TABで順に補完候補を切り替える
setopt auto_menu

## zshの開始、終了時刻をヒストリファイルに書き込む
setopt extended_history

## =commandをcommandのパス名に展開する
setopt equals

## --prefix=/usrなどの=以降も補完
setopt magic_equal_subst

## ヒストリを呼び出してから実行する間に一旦編集
setopt hist_verify

## ファイル名の展開で辞書順ではなく数値的にソート
#setopt numeric_glob_sort

## 出力時8ビットを通す
setopt print_eight_bit

## ヒストリを共有
setopt share_history

## 補完候補のカーソル選択を有効に
zstyle ':completion:*:default' menu select=1

## 補完候補の色付け
eval `dircolors`
export ZLS_COLORS=$LS_COLORS
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

## ディレクトリ名だけでcd
setopt auto_cd

## cdしたらls
function chpwd(){ls -F --color}

## mkdirしたらcd
function mkdircd(){ mkdir $@ && cd $_ }

## カッコの対応などを自動的に補完
setopt auto_param_keys

## ディレクトリ名の補完で末尾の/を自動的に付加し、次の補完に備える
setopt auto_param_slash

## スペルチェック
setopt correct

## スペルチェックの例外設定
alias lv="nocorrect lv"

## エイリアス
setopt complete_aliases
alias ls="ls -F --color"
#alias la="ls -a"
#alias lf="ls -F"
#alias ll="ls -l"
#alias du="du -h"
#alias df="df -h"
alias g++0x="g++ -std=c++0x"

## 最後のスラッシュを自動的に削除しない
setopt noautoremoveslash

## 検索
#export WEB_BROWSER=firefox
export WEB_BROWSER=google-chrome

function _space2plus
{
    echo $@ | sed -e "s/ /+/g"
}

function google
{
    ${WEB_BROWSER} "http://www.google.co.jp/search?q="`_space2plus $@`"&hl=ja"
}

function dic-en
{
    ${WEB_BROWSER} "http://dictionary.cambridge.org/results.asp?searchword="`_space2plus $@`"&x=0&y=0"
}

function dic-ya
{
    ${WEB_BROWSER} "http://dic.yahoo.co.jp/dsearch?p="`_space2plus $@`
}

# w3m版
function google-w
{
    w3m "http://www.google.co.jp/search?q="`_space2plus $@`"&hl=ja"
}

function dic-ya-w
{
    w3m "http://dic.yahoo.co.jp/dsearch?enc=UTF-8&p="`_space2plus $@`"&dtype=1"
}




## ここから下はここまでの設定を特定環境下で変更させる場合に記述する。

## エスケープ文字とか機能が問題になる場合の調整
case "${TERM}" in
    dumb)
        unsetopt zle
        PROMPT="[%/]"$'\n'"%n@%M> "
        ;;
    emacs)
        unsetopt zle
        ;;
esac


echo "[`pwd`]"
ls --color
echo ""
