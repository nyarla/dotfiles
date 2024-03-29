_:
let
  makeExecute = label: command: ''
    <item label="${label}">
      <action name="Execute">
        <command>${command}</command>
      </action>
    </item>
  '';

  makeAction = label: action: ''
    <item label="${label}">
      <action name="${action}" />
    </item>
  '';

  makeMenu = id: label: items: ''
    <menu id="${id}" label="${label}">
      ${builtins.concatStringsSep "\n" items}
    </menu>
  '';

  makeMenuItem = id: ''
    <menu id="${id}"/>
  '';

  sep = ''
    <separator />
  '';

  scripts = "/home/nyarla/local/dotfiles/scripts";
  scriptsCmd = cmd: "${scripts}/${cmd}";
  activateCmd = cmd: class:
    "${scripts}/window-activate ${cmd} &#39;${class}&#39;";

  wine = "/home/nyarla/local/dotfiles/wine";
  wineCmd = app: "${wine}/${app}";

in ''
  <?xml version="1.0" encoding="UTF-8"?>
  <openbox_menu xmlns="http://openbox.org/3.4/menu">

  ${makeMenu "applications-main" "Main" [
    (makeExecute "mlterm" (scriptsCmd "mlterm"))
    (makeExecute "notes" (scriptsCmd "notes"))
    #(makeExecute "mining" (scriptsCmd "mining"))
    (makeExecute "virt-manager" "virt-manager")
  ]}

  ${makeMenu "applications-web" "Web" [
    (makeExecute "Firefox" "firefox")
    (makeExecute "Thunderbird" "thunderbird")
    (makeExecute "!Google Chrome" "google-chrome-stable")
    (makeExecute "Bitwarden" "bitwarden --no-sandbox")
  ]}

  ${makeMenu "applications-file" "Files" [
    (makeExecute "Caja" "env GDK_BACKEND=x11 caja --display=:0.0")
    (makeExecute "Atril" "atril")
    (makeExecute "Pluma" "pluma")
  ]}

  ${makeMenu "applications-multimedia" "Multimedia" [
    (makeExecute "!Calibre" "calibre")
    (makeExecute "QuodLibet" "quodlibet")
    (makeExecute "!Picard" "picard")
    (makeExecute "Mp3tag" (wineCmd "Mp3tag"))
    "${sep}"
    (makeExecute "Audacity" "audacity")
    (makeExecute "DeaDBeeF" "deadbeef")
    "${sep}"
    (makeExecute "Kindle" (wineCmd "Kindle"))
    (makeExecute "!Amazon Music" (wineCmd "AmazonMusic"))
  ]}

  ${makeMenu "applications-chat" "Chat" [
    (makeExecute "Droidcam" "droidcam")
    (makeExecute "Slack" "slack --disable-gpu")
    (makeExecute "Discord" "discord --no-sandbox")
    (makeExecute "Telegram" "telegram-desktop")
  ]}

  ${makeMenu "applications-office" "Office" [
    (makeExecute "Calc" "mate-calc")
    (makeExecute "Char Maps" "gucharmap")
    "${sep}"
    (makeExecute "Gimp" "gimp")
    (makeExecute "Inkscape" "inkscape")
    "${sep}"
    (makeExecute "Spice up" "com.github.philip-scott.spice-up")
    (makeExecute "Simple Scan" "simple-scan")
    (makeExecute "GIF capture" "env GDK_BACKEND=x11 peek")
  ]}

  ${makeMenu "applications-daw" "Music" [
    (makeMenu "submenu-jack" "JackAudio" [
      (makeExecute "QjackCtl" "qjackctl")
      (makeExecute "Carla" "carla")
    ])

    (makeMenu "submenu-daw" "DAW" [
      (makeExecute "Bitwig Studio" "bitwig-studio")
      (makeExecute "Zrythm" "zrythm")
      (makeExecute "Helio.fm" "helio")
      (makeExecute "MuseScore" "musescore")
      "${sep}"
      (makeExecute "!FL Studio" (wineCmd "FLStudio"))
      (makeExecute "!deCoda" (wineCmd "deCoda"))
    ])

    (makeMenu "submenu-authorizer" "Authorizer" [
      (makeExecute "Arturia" (wineCmd "Arturia"))
      (makeExecute "eLicenser" (wineCmd "eLicenser"))
      (makeExecute "Native Access" (wineCmd "NativeAccess"))
      (makeExecute "IK Multimedia" (wineCmd "IKMultimedia"))
    ])
  ]}

  ${makeMenu "system-utils" "Utilities" [
    (makeExecute "Audio" "pavucontrol")
    (makeExecute "System Monitor" "mate-system-monitor")
    (makeExecute "Network" "nm-connection-editor")
    (makeExecute "Bluetooth" "blueman-manager")
  ]}

  ${makeMenu "system-actions" "System" [
    (makeExecute "Reconfigure" "zsh -c 'kill -SIGHUP $(pgrep labwc)'")
    (makeExecute "Lock" "swaylock")
    (makeAction "Logout" "Exit")
    (makeExecute "Reboot" "systemctl reboot")
  ]}

  ${makeMenu "client-menu" "Labwc" [

  ]}

  ${makeMenu "root-menu" "Labwc" [
    (makeMenuItem "applications-main")
    (makeMenuItem "applications-file")
    "${sep}"
    (makeMenuItem "applications-web")
    (makeMenuItem "applications-multimedia")
    (makeMenuItem "applications-daw")
    "${sep}"
    (makeMenuItem "applications-office")
    (makeMenuItem "applications-chat")
    "${sep}"
    (makeMenuItem "system-utils")
    (makeMenuItem "system-actions")
  ]}
  </openbox_menu>
''
