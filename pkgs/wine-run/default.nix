{ writeShellScript, runCommand }:
let
  wine-run = writeShellScript "wine-run" ''
    export LD_PRELOAD=

    case "$(pwd)/" in
      /run/media/nyarla/src/local/daw/*/*/)
        export WINEPREFIX=$(pwd)
        chmod +w ''${WINEPREFIX}/drive_c/windows/system/wineasio.dll 
        cp /run/current-system/sw/lib/wine/x86_64-unix/wineasio.dll.so \
          "''${WINEPREFIX}/drive_c/windows/system/wineasio.dll"
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
