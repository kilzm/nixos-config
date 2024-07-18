{ config, lib, pkgs, ... }: 
let
  hicolorTheme = {
    package = pkgs.hicolor-icon-theme;
    name = "hicolor";
    size = "32x32";
  };
  basePaths = [
    "/run/current-system/sw"
    config.home.profileDirectory
    hicolorTheme.package
  ];
  themes = [hicolorTheme];
  categories = [
    "actions"
    "animations"
    "apps"
    "categories"
    "devices"
    "emblems"
    "emotes"
    "filesystem"
    "intl"
    "legacy"
    "mimetypes"
    "places"
    "status"
    "stock"
  ];
  mkPath = {
    basePath,
    theme,
    category,
  }: "${basePath}/share/icons/${theme.name}/${theme.size}/${category}";
  iconPath = lib.concatMapStringsSep ":" mkPath (lib.cartesianProduct {
    basePath = basePaths;
    theme = themes;
    category = categories;
  });
in {
  programs.pywal16.templates.colors-dunstrc = ''
    [global]
      frame_color = "{color1}"
      origin = top-right
      follow = "mouse"
      offset = "30x30"
      separator_height = 2
      frame_width = 3
      padding = 8
      text_icon_padding = 15
      separator_color = "frame"
      idle_threshold = 120
      line_height = 0
      format = "<b>%s</b>\n%b"
      alignment = "left"
      icon_position = "left"
      corner_radius = 6
      font = "${config.theming.fonts.sans} 13"
      icon_path = "${iconPath}"

    [urgency_normal]
      foreground = "{foreground}"
      background = "{background}"

    [urgency_low]
      foreground = "{foreground}"
      background = "{background}"
    
    [urgency_critical]
      foreground = "{foreground}"
      background = "{background}"
  '';

  systemd.user.services.dunst = {
    Unit = {
      Description = "Dunst notification daemon";
    };

    Install.WantedBy = [ "graphical-session.target" ];

    Service = {
      ExecStart = "${pkgs.dunst}/bin/dunst -config ~/.cache/wal/colors-dunstrc";
    };
  };
}
