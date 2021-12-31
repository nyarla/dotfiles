{ pkgs, lib, ... }: {
  programs.zsh = {
    enable = true;
    autocd = true;
    shellAliases = {
      "cd" = "__cd";
      "ls" = "ls --color -F";
      "nvim-resume" = "pkill -SIGCONT nvim";
      "rm" = "trash";
      "nixos-upgrade" =
        ''sudo nixos-rebuild boot --flake "/etc/nixos#$(hostname)"'';
      "nixos-apply" =
        ''sudo nixos-rebuild switch --flake "/etc/nixos#$(hostname)"'';
    };
    sessionVariables = {
      GOPATH = "$HOME/dev";
      BUP_DIR = "/run/media/nyarla/src/local/bup";
      EDITOR = "nvim";
      PATH = lib.strings.concatStringsSep ":" [
        "$HOME/.local/share/npm/bin"
        "$HOME/dev/bin"
        "$HOME/local/bin"
        "$PATH"
      ];
    };
    enableCompletion = true;
    enableSyntaxHighlighting = true;
    history = {
      size = 10000;
      path = "$HOME/.zsh_history";
      ignorePatterns = [ ];
      ignoreDups = true;
      share = true;
    };
    plugins = [{
      name = "z";
      file = "z.sh";
      src = pkgs.fetchFromGitHub {
        owner = "rupa";
        repo = "z";
        rev = "b82ac78a2d4457d2ca09973332638f123f065fd1";
        sha256 = "sha256-4jMHh1GVRdFNjUjiPH94vewbfLcah7Agu153zjVNE14=";
      };
    }];
    initExtraFirst = ''
      # change cursor to underline
      echo -en '\033[3 q'

      # utility function
      function has() {
        type "''${1:-}" >/dev/null 2>&1
      }
    '';
    initExtraBeforeCompInit = ''
      if has perl && test -d $HOME/.local/share/perl ; then
        eval "$(perl -I"$HOME"/.local/share/perl/lib/perl5 -Mlocal::lib="$HOME"/.local/share/perl)"
        export PERL_CPANM_OPT="--local-lib-contained $HOME/.local/share/perl"
      fi

      if test -e $HOME/.cargo/env ; then
        source $HOME/.cargo/env
      fi
    '';
    initExtra = ''
      setopt auto_pushd
      setopt pushd_ignore_dups
      setopt pushd_to_home
      setopt hist_ignore_all_dups
      setopt hist_reduce_blanks
      setopt hist_find_no_dups

      function nix-clean() {
        nix-store --gc
        sudo nix-env -p /nix/var/nix/profiles/system --delete-generations +14
        sudo nix-store --optimize --verbose
        sudo /run/current-system/bin/switch-to-configuration boot
      }

      function nix-clean-all() {
        nix-store --gc
        sudo nix-store --gc
        sudo nix-collect-garbage -d
        sudo /run/current-system/bin/switch-to-configuration boot
      }

      if has fzy ; then
        function fzy-history() {
          BUFFER="$(fc -l -n 1 | sort -u | fzy --query "''${LBUFFER}")"
          CURSOR=$#BUFFER
          zle -R -c
        }

        zle -N fzy-history
        bindkey '^R' fzy-history
      fi

      function __cd() {
        local dir=''${1:-}

        if test  "x''${dir}" = "x" ; then
          local dir=$(z -l | sed 's/ \+/ /g' | cut -d\   -f2 | fzy | sed "s!~!$HOME!")
          \cd "''${dir}"
          z --add "''${dir}"
        else
          \cd "''${dir}"
          z --add "''${dir}"         
        fi
      }

      unset -f has
    '';
  };

}
