{ ... }: {
  programs.git = {
    enable = true;
    userName = "Kilian Markl";
    userEmail = "kilian02.markl@gmail.com";
    difftastic.enable = true;
  };

  programs.lazygit = {
    enable = true;
    settings = {
      gui = {
        border = "rounded";
        theme = {
          inactiveBorderColor = [ "#363646" ];
          activeBorderColor = [ "default" "bold" ];
        };
      };
    };
  };
}
