{...}: {
  programs.git = {
    enable = true;
    userName = "Kilian Markl";
    userEmail = "kilian02.markl@gmail.com";
  };

  programs.lazygit = {
    enable = true;
    settings = {
      gui = {
        border = "rounded";
        theme = {
          inactiveBorderColor = ["#363636"];
          activeBorderColor = [
            "default"
            "bold"
          ];
        };
      };
    };
  };
}
