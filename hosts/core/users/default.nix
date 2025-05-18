{...}: {
  users.users.kilianm = {
    isNormalUser = true;
    description = "Kilian Markl";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };
}
