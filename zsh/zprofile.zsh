#!/usr/bin/env zsh

# zprofile (for login)
# ====================

CWD="$(pwd)"

function has() {
  type ${1:-} >/dev/null 2>&1
}

# keychain (for ssh and mosh)
# ---------------------------

if has keychain ; then 
  keychain --nogui --quiet "$HOME"/.ssh/id_ed25519
  source "$HOME"/.keychain/$(hostname)-sh
fi

unset -f has
