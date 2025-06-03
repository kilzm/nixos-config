{...}: {
  programs.git = {
    enable = true;
    userName = "Kilian Markl";
    userEmail = "kilian02.markl@gmail.com";
    extraConfig = {
      core = {
        whitespace = "trailing-space, space-before-tab";
        preloadindex = true;
      };
      "url \"git@github.com:kilzm/\"" = {
        insteadOf = "km:";
      };
      "url \"git@github.com:\"" = {
        insteadOf = "gh:";
      };
      status = {
        branch = true;
        showStash = true;
      };
      pull = {
        rebase = true;
      };
      rebase = {
        autoStash = true;
        missingCommitsCheck = "warn";
      };
    };
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
