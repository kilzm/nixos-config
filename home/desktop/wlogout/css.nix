{ font, palette, pkgs }:
let
  fetchIcon =
    { name
    , color ? palette.base05
    , hash
    }: "${pkgs.stdenvNoCC.mkDerivation {
    name = "${name}-icon";
    src = pkgs.fetchurl {
        url = "https://www.iconsdb.com/icons/download/color/${color}/${name}-512.png";
        inherit hash;
    };
    dontUnpack = true;
    dontBuild = true;
    installPhase = ''
      mkdir $out
      cp $src $out/icon.png
    '';
  }}/icon.png";

  lock = fetchIcon {
    name = "lock";
    hash = "sha256-ih7L45shI2a3Q0IgWl1yqfixGvVY4f6Ish/lfl/NQmA=";
  };

  logout = fetchIcon {
    name = "logout";
    hash = "sha256-xlsLTEzaGCsOhA24yG/ZblqzuHOk+tcOWQeH2muGfD4=";
  };

  shutdown = fetchIcon {
    name = "power-2";
    hash = "sha256-2uGubk9t5AIU5gssWaoJG9BIvHt4WHP+766hhoPz4qw=";
  };

  reboot = fetchIcon {
    name = "recurring-appointment";
    hash = "sha256-EtKSqJRA0aOiRs00GmnvbbaLDkTiITKOGdNBgyefz78=";
  };

  suspend = fetchIcon {
    name = "pause";
    hash = "sha256-PLUiMyPedAZspPNz+bVVm6BCEBvU3Hq+LcrJHjGueog=";
  };

in
# https://github.com/klpod221/klpod0s/blob/main/configs/.config/wlogout/style_1.css
''
  window {
    font-family: ${font};
    font-size: 20px;
    background-image: none;
    transition: 20ms;
  }

  window {
    background-color: rgba(12, 12, 12, 0.3);
  }

  button {
    color: #${palette.base05};
    background-color: #${palette.base00};
    outline-style: none;
    border: none;
    border-width: 0px;
    background-repeat: no-repeat;
    background-position: center;
    background-size: 20%;
    border-radius: 0px;
    box-shadow: none;
    text-shadow: none;
    animation: gradient_f 20s ease-in infinite;
  }

  button:hover {
    background-color: #${palette.base03};
    background-size: 30%;
    border-radius: 40px;
    animation: gradient_f 20s ease-in infinite;
    transition: all 0.3s cubic-bezier(.55,0.0,.28,1.682);
  }

  button:hover#lock {
    border-radius: 40px;
    margin: 300px 0px 300px 300px;
  }

  button:hover#logout {
    border-radius: 40px;
    margin: 300px 0px 300px 0px;
  }

  button:hover#shutdown {
    border-radius: 40px;
    margin: 300px 0px 300px 0px;
  }

  button:hover#reboot {
    border-radius: 40px;
    margin: 300px 0px 300px 0px;
  }

  button:hover#suspend {
    border-radius: 40px;
    margin: 300px 300px 300px 0px;
  }

  #lock {
    background-image: image(url("${lock}"));
    margin: 350px 0px 350px 300px;
    border-radius: 40px 0px 0px 40px;
  }

  #logout {
    background-image: image(url("${logout}"));
    margin: 350px 0px 350px 0px;
  }

  #shutdown {
    background-image: image(url("${shutdown}"));
    margin: 350px 0px 350px 0px;
  }

  #reboot {
    background-image: image(url("${reboot}"));
    margin: 350px 0px 350px 0px;
  }

  #suspend {
    background-image: image(url("${suspend}"));
    margin: 350px 300px 350px 0px;
    border-radius: 0px 40px 40px 0px;
  }
''
