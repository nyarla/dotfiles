#!/usr/bin/env zsh

# zshenv (for login, interactive or shell script)
# ===========================================


function has() {
  type "${1:-}" 2>&1 >/dev/null
}

# Perl
# ----
if has perl && test -d "$HOME"/.config/perl5 ; then
  eval "$(perl -I"$HOME"/.config/perl5/lib/perl5 -Mlocal::lib="$HOME"/.config/perl5)"
  export PERL_CPANM_OPT="--local-lib-contained ${HOME}/.config/perl5"
fi

# Go
# --
export GOPATH="$HOME"/dev
! test -d "$GOPATH"/bin             || export PATH="$GOPATH"/bin:$PATH

# Node.js (npm)
# -------------
! test -d "$HOME"/.config/npm/bin   || export PATH="$HOME"/.config/npm/bin:$PATH

# Rust (cargo)
# ------------
! test -d "$HOME"/.cargo/env        || source "$HOME"/.cargo/env

# Java (OpenJDK)
# --------------
! test -e /etc/openjdk              || export JDK_HOME=/etc/openjdk

# Volt (vim plugin manager)
# -------------------------
! test -e"$HOME"/.config/volt  || export VOLTPATH="$HOME"/.config/volt

# Scripts (on local machine)
# --------------------------
! test -d "$HOME"/local/bin       || export PATH="$HOME"/local/bin:$PATH

# EDTIOR (vim)
# ------------
if has vim ; then
  export EDITOR=vim
fi

# cleanup (PATH)
# --------------
path=(${^path}(N-/^W))
unset -f has
