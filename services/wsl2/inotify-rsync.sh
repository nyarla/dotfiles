#!/usr/bin/env bash

SRC=/home/nyarla/dev/src/github.com/nyarla
DEST=/mnt/z/Files/live/dev/github.com/nyarla

inotifywait -r -m -e modify,create,delete,moved_to,moved_from --format '%w%f' $SRC | while read file; do
  if test -e $file; then
    rsync -ruv --modify-window=1 --delete --filter='dir-merge,-n /.gitignore' --exclude-from=$HOME/.gitignore \
      "${file}" "${DEST}${file#$SRC}"
  else
    rm -rf "${DEST}${file#$SRC}"
  fi
done > $HOME/.cache/inotify-rsync.log
