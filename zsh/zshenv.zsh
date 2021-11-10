#!/usr/bin/env zsh

# zshenv (for login, interactive or shell script)
# ===========================================


function has() {
  type "${1:-}" >/dev/null 2>&1
}

# Perl
# ----
if has perl && test -d "$HOME"/.local/share/perl ; then
  eval "$(perl -I"$HOME"/.config/perl/lib/perl5 -Mlocal::lib="$HOME"/.config/perl)"
  export PERL_CPANM_OPT="--local-lib-contained ${HOME}/.config/perl"
fi

# Go
# --
export GOPATH="$HOME"/dev
! test -d "$GOPATH"/bin             || export PATH="$GOPATH"/bin:$PATH

# Node.js (npm)
# -------------
! test -d "$HOME"/.local/share/npm/bin || export PATH="$HOME"/.local/share/npm/bin:$PATH

# Rust (cargo)
# ------------
! test -d "$HOME"/.cargo/env        || source "$HOME"/.cargo/env

# Java (OpenJDK)
# --------------
! test -e /etc/openjdk              || export JDK_HOME=/etc/openjdk

# Scripts (on local machine)
# --------------------------
! test -d "$HOME"/local/bin         || export PATH="$HOME"/local/bin:$PATH

# Bup
# ---
if test -d /run/media/nyarla/src/local/bup ; then
  export BUP_DIR=/run/media/nyarla/src/local/bup
fi

# EDTIOR (vim)
# ------------
if has nvim ; then
  export EDITOR=nvim
fi

# cleanup (PATH)
# --------------
path=(${^path}(N-/^W))
unset -f has
