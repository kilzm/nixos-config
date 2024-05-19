{ cmn, ... }:
{
  services.dunst = {
    settings.global = {
      font = "${cmn.font} 13";
    };
  };
}
