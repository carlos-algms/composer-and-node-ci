PROMPT=$'\n'"%B%F{green}%n%f %F{blue}%~%f%b"$'\n'"λ "

alias ls='/bin/ls --color=auto -F --group-directories-first'
alias ll='ls -l'
alias lsa='ls -la'
alias l='ls -lA'

extract () {
    if [ -f $1 ] ; then
        filename=$(basename -- "$1")
        filename="${filename%.*}"
        target="${2-"./$filename"}"

        case $1 in
            *.tar.bz2)   tar xvjf $1 -C "$target"   ;;
            *.tar.gz)    tar xvzf $1 -C "$target"   ;;
            *.tar.xz)    tar xJf $1 -C "$target"    ;;
            *.bz2)       bunzip2 $1                 ;;
            *.rar)       rar x $1 "$target"         ;;
            *.gz)        gunzip $1                  ;;
            *.tar)       tar xvf $1  -C "$target"   ;;
            *.tbz2)      tar xvjf $1 -C "$target"   ;;
            *.tgz)       tar xvzf $1 -C "$target"   ;;
            *.zip)       unzip $1 -d "$target"      ;;
            *.Z)         uncompress $1              ;;
            *.7z)        7z x $1 -o"$target"        ;;
            *)           echo "don't know how to extract '$1'..." ;;
        esac
    else
        echo "'$1' is not a valid file!"
    fi
}


# Cycle through history based on characters already typed on the line
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "$key[Up]" up-line-or-beginning-search
bindkey "$key[Down]" down-line-or-beginning-search
