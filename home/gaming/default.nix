{ pkgs, ... }: {
  home.packages = with pkgs; [ wine winetricks heroic rare lutris prismlauncher ];
}
