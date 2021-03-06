#!/usr/bin/env zsh

# init (zsh plugins)
# ------------------

function has() {
  type ${1:-} >/dev/null 2>&1
}

! test -e "$HOME"/.config/zsh/z || source "$HOME"/.config/zsh/z/z.sh
if has starship ; then
  eval "$(starship init zsh)"
  export RPS1=""
fi

# zshrc (for login or interactive)
# ================================

# zsh options
# -----------
setopt autocd
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushd_to_home

setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt hist_reduce_blanks
setopt hist_find_no_dups
setopt share_history

test "${HISTFILE:-}" != "" || export HISTFILE="$HOME"/.zsh_history
test "${HISTSIZE:-}" != "" || export HISTSIZE=1024
test "${SAVEHIST:-}" != "" || export SAVEHIST=1024

# nix and nixos
# -------------

if has nix-env ; then
  if test -d /etc/nixpkgs ; then
    alias nix-build="nix-build -I nixpkgs=/etc/nixpkgs"
    alias nix-env="nix-env -I nixpkgs=/etc/nixpkgs"
    alias nix-shell="nix-shell -I nixpkgs=/etc/nixpkgs"
    alias nix-search="nix search -I nixpkgs=/etc/nixpkgs"

    if has nixos-rebuild ; then
      alias nixos-apply="sudo nixos-rebuild -I nixpkgs=/etc/nixpkgs switch"
      alias nixos-upgrade="sudo nixos-rebuild -I nixpkgs=/etc/nixpkgs boot"
    fi
  else
    alias nix-search"nix search"

    if has nixos-rebuild ; then
      alias nixos-apply="sudo nixos-rebuild switch"
      alias nixos-upgrade="sudo nixos-rebuild boot"
    fi
  fi

  if has nixos-rebuild ; then
    function nix-clean() {
      nix-store --gc
      sudo nix-store --gc
      sudo nix-collect-garbage -d
      sudo /run/current-system/bin/switch-to-configuration boot
    }
  else
    alias nix-clean="nix-store --gc"
  fi

  function nix-prepare() {
    find "$HOME"/local/files \
      -type f -name '*.*' \
      | xargs -I{} nix-prefetch-url "file://{}"
  }
fi

# command-specific
# ----------------

if has fzy ; then
  function fzy-history() {
    BUFFER="$(fc -l -n 1 | sort | uniq | fzy --query "${LBUFFER}")"
    CURSOR=$#BUFFER
    zle -R -c
  }

  zle -N fzy-history
  bindkey '^R' fzy-history

  if test -e $HOME/.config/zsh/z ; then
    function __cd() {
      local dir="${1:-}"

      if test "x${dir}" = "x"; then
        local dir="$(z -l | sed 's/ \+/ /g' | cut -d\  -f2 | sort -u | fzy | sed "s:~:$HOME:")"
        \cd "$dir"
        z --add "$dir"
      else
        \cd "$dir"
        z --add "$dir"
      fi
    }

    alias cd="__cd"
  fi
fi

if has wcwidth-cjk && has mosh ; then
  alias mosh="mosh --server='wcwidth-cjk mosh-server'"
fi

# os-specific
# -----------

case "$(uname -s | tr '[:upper:]' '[:lower:]')" in
  linux)
    alias ls="ls --color -F"
    alias rm="trash"
    alias resume-nvim="pkill -SIGCONT nvim"

    if test "x${NVIM_LISTEN_ADDRESS}" != "x" ; then
      alias nvim="nvr"
    fi
    ;;
  darwin)
    alias ls="ls -GF"
    alias rm="trash"
    ;;
  *_nt-*)
    alias ls="ls -GF"
    alias rm="trash"

    # workaround for WSL1
    # unsetopt BG_NICE
    # umask 022
    # alias exit="sh -c \"cmd /C 'taskkill /F /T /PID $(cat /proc/$$/winpid)'\""
    # trap 'sh -c "cmd /C \"taskkill /F /T /PID $(cat /proc/$$/winpid)\""' 1 2 3 15
    ;;
esac
# finalize
# --------
unset -f has
