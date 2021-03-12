#!/usr/bin/env zsh

# zprofile (for login)
# ====================

CWD="$(pwd)"

function has() {
  type ${1:-} >/dev/null 2>&1
}

# wcwidth-cjk (for cjk)
# --------------------

if has wcwidth-cjk && has wcwidth; then
  case "$(uname -s)" in
    *Linux*)
      if has wcwidth-cjk && ! [[ "${LD_PRELOAD}" =~ .*wcwidth-cjk.so* ]]; then
        exec wcwidth-cjk $SHELL --login
      fi
      ;;
  esac
fi

# keychain (for ssh and mosh)
# ---------------------------

if has keychain ; then 
  keychain --nogui --quiet "$HOME"/.ssh/id_ed25519
  source "$HOME"/.keychain/$(hostname)-sh
fi

# resilio sync
# ------------
if pgrep rslsync >/dev/null 2>&1; then
  umask 002
fi

unset -f has
