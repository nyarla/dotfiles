{ color, pkgs }:
let
  optional = {
    "x86_64-linux" = {
      use_xim = false;
      input_method = "fcitx";
      type_engine = "xft";
    };
  };
in {
  # terminal
  use_login_shell = true;
  termtype = "mlterm-256color";
  encoding = "UTF-8";
  col_size_of_width_a = 2;
  bidi_mode = "left";

  # font
  fontsize = 16;
  line_space = 2;
  use_anti_alias = true;
  box_drawing_font = "unicode";

  # appearance
  scrollbar_mode = false;
  vt_color_mode = true;
  blink_cursor = true;

  bg_color = color.black;
  fg_color = color.hl_white;

  cursor_bg_color = color.hl_green;
  cursor_fg_color = color.black;

  tab_size = 2;
  log_size = 4096;

  # others

  mod_meta_key = "alt";
  mod_meta_mode = "esc";
  use_clipboard = true;
} // optional."${pkgs.stdenv.system}"
