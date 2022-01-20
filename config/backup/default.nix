{ pkgs, ... }: {
  systemd.user.services.backup = {
    enable = true;
    description = "Automatic backup by restic and rclone";
    wantedBy = [ "multi-user.target" ];
    path = [ pkgs.restic-run ];
    unitConfig = {
      RefuseManualStart = "no";
      RefuseManualStop = "yes";
    };
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = "yes";
      ExecStart = pkgs.writeShellScript "backup-dotfiles.sh" ''
        # ~/Documents
        cd ~/Documents && restic-backup documents .

        # ~/Music
        cd ~/Music && rstic-backup musics .

        # ~/local
        cd ~/local && restic-backup dotfiles .

        if test "$(hostname)" = "nixos" ; then
          # /run/media/nyarla/data/Downloads
          (cd /run/media/nyarla/data/Downloads && restic-backup stuck .)

          # /run/media/nyarla/data/local
          (cd /run/media/nyarla/data/local && restic-run source .)

          # /run/media/nyarla/src/local
          (cd /run/media/nyarla/src/local && restic-run daw .)
        fi
      '';
    };
  };

  systemd.user.timer.backup = {
    enable = false;
    description = "system timer for automatic backup";
    wantedBy = [ "timer.target" "multi-user.target" ];
    timerConfig = {
      OnCalendar = "*-*-* 02:00:00";
      Persistent = "yes";
    };
  };
}
