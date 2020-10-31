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
  if test "$(wcwidth '○' | cut -d' ' -f1)" = "1" ; then
    exec wcwidth-cjk $SHELL --login
  fi
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
