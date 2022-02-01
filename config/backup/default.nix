{ pkgs, ... }: {
  systemd.user.services.backup = {
    Unit = { Description = "Automatic backup by restic and rclone"; };
    Install = { RequiredBy = [ "default.target" ]; };
    Service = {
      Type = "oneshot";
      ExecStart = "${pkgs.writeShellScript "backup.sh" ''
        export PATH=${pkgs.restic-run}/bin:$PATH

        if test -e ~/.cache/backup.lock ; then
          echo "backup process is running or dead lokced"
          exit 0
        fi

        touch ~/.cache/backup.lock

        # ~/Documents
        cd ~/Documents && restic-backup documents .

        # ~/Music
        # cd ~/Music && restic-backup musics .

        # ~/local
        cd ~/local && restic-backup dotfiles .

        if test "$(hostname)" = "nixos" ; then
          # /run/media/nyarla/data/Downloads
          (cd /run/media/nyarla/data/Downloads && restic-backup stuck .)

          # /run/media/nyarla/data/local
          (cd /run/media/nyarla/data/local && restic-backup source .)

          # /run/media/nyarla/src/local
          (cd /run/media/nyarla/src/local && restic-backup daw .)
          
          # /run/media/nyarla/src/Music
          (cd /run/media/nyarla/src/Music && restic-backup musics .)
        fi

        rm ~/.cache/backup.lock
      ''}";
    };
  };

  systemd.user.timers.backup = {
    Unit = { Description = "Timer for automatic backup by restic and rclone"; };

    Timer = {
      OnCalendar = "*-*-* 02:00:00";
      RandomizedDelaySec = "5m";
      Persistent = true;
      Unit = "backup.service";
    };

    Install = { WantedBy = [ "timers.target" ]; };
  };
}
