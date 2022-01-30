{ runCommand, writeShellScript, restic, rclone }:
let

  resticInit = ''
    set -euo pipefail

    if test -z "''${1:-}" ; then
      echo "Usage: ''${0} <name>" >&2
      exit 1
    fi

    export HOME=/home/nyarla
    export RESTIC_PASSWORD_FILE=$HOME/.config/rclone/restic
    export RESTIC_FORGET_ARGS="--prune --keep-daily 7 --keep-weekly 2 --keep-monthly 3"
    export RESTIC_BACKUP_ARGS="--exclude-file $HOME/.config/rclone/ignore"
    export RESTIC_REPOSITORY=rclone:Teracloud:Restic/$(hostname)/''${1}

    restic-run() {
      args=(''${@})
      unset args[0]
      unset args[1]
      args=("''${args[@]}")
      
      ${restic}/bin/restic ''${1:-} -o=rclone.program="${rclone}/bin/rclone" ''${args[@]}
    }
  '';

  resticWrapper = writeShellScript "restic.sh" ''
    ${resticInit}

    restic-run $@ 
  '';

  resticBackupScript = writeShellScript "restic-backup.sh" ''
    ${resticInit}

    restic-run unlock --remove-all
    restic-run rebuild-index
    restic-run prune
    restic-run backup $RESTIC_BACKUP_ARGS $@
    restic-run forget $RESTIC_FORGET_ARGS
  '';
in runCommand "restic-run" { } ''
  mkdir -p $out/bin
  cp ${resticWrapper} $out/bin/restic-run
  cp ${resticBackupScript} $out/bin/restic-backup
  chmod +x $out/bin/*
''
