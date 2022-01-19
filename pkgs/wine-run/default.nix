{ writeShellScript, runCommand }:
let
  wine-run = writeShellScript "wine-run" ''
    export LD_PRELOAD=

    case "$(pwd)/" in
      /run/media/nyarla/src/local/daw/*/*/)
        export WINEPREFIX=$(pwd)
        ;;
      $HOME/local/wine/*/)
        export WINEPREFIX=$(pwd)
        ;;
      *)
        echo 'This path does not contain wine prefix'
        exit 1
    esac

    exec $@
  '';
in runCommand "wine-run" { } ''
  mkdir -p $out/bin
  cp ${wine-run} $out/bin/wine-run
  chmod +x $out/bin/wine-run
''
