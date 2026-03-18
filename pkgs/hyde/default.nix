{
  pkgs,
  lib,
  fetchFromGitHub,
}:
pkgs.stdenv.mkDerivation {
  name = "hyde";
  version = "25.10.1-unstable-2026-03-04";

  src = fetchFromGitHub {
    owner = "HyDE-Project";
    repo = "HyDE";
    rev = "9f488f530be17e738959c6c4952ea46f9271533f"; # renovate: branch="dev"
    hash = "sha256-Hpk3l2WU7RrFnT+UA6zAFAX+WQ00tsoTeT1McMB9VPw=";
  };

  nativeBuildInputs = with pkgs; [
    gnutar
    unzip
    makeWrapper
  ];

  buildPhase = ''
    runHook preBuild

    # remove assets folder
    rm -rf Source/assets

    rm -rf Configs/.local/lib/hyde/resetxdgportal.sh
    rm -rf Configs/.local/bin/hydectl
    rm -rf Configs/.local/bin/hyde-ipc
    rm -rf Configs/.local/lib/hyde/hyde-config
    rm -rf Configs/.local/lib/hyde/hyq
    rm -rf Configs/.local/bin/hyq

    # Update waybar killall command in all HyDE files
    find . -type f -print0 | xargs -0 sed -i 's/killall waybar/killall .waybar-wrapped/g'

    # update dunst
    find . -type f -print0 | xargs -0 sed -i 's/killall dunst/killall .dunst-wrapped/g'

    # update kitty
    find . -type f -print0 | xargs -0 sed -i 's/killall kitty/killall .kitty-wrapped/g'
    find . -type f -print0 | xargs -0 sed -i 's/killall -SIGUSR1 kitty/killall -SIGUSR1 .kitty-wrapped/g'

    # fix find commands for symlinks
    find . -type f -executable -print0 | xargs -0 sed -i 's/find "/find -L "/g'
    find . -type f -name "*.sh" -print0 | xargs -0 sed -i 's/find "/find -L "/g'

    # remove lines 187-190 from Configs/.local/lib/hyde/theme.switch.sh
    # fixes gtk4 themes
    sed -i '187,190d' Configs/.local/lib/hyde/theme.switch.sh

    # remove pkill command from rofilaunch.sh
    sed -i '5d' Configs/.local/lib/hyde/rofilaunch.sh

    # BUILD FONTS
    mkdir -p $out/share/fonts/truetype
    for fontarchive in ./Source/arcs/Font_*.tar.gz; do
      if [ -f "$fontarchive" ]; then
        tar xzf "$fontarchive" -C $out/share/fonts/truetype/
      fi
    done

    # BUILD VSCODE EXTENSION
    mkdir -p $out/share/vscode/extensions/prasanthrangan.wallbash
    unzip ./Source/arcs/Code_Wallbash.vsix -d $out/share/vscode/extensions/prasanthrangan.wallbash
    # Ensure extension is readable and executable
    chmod -R a+rX $out/share/vscode/extensions/prasanthrangan.wallbash

    # BUILD GRUB THEMES
    mkdir -p $out/share/grub/themes
    tar xzf ./Source/arcs/Grub_Retroboot.tar.gz -C $out/share/grub/themes
    tar xzf ./Source/arcs/Grub_Pochita.tar.gz -C $out/share/grub/themes

    # BUILD ICONS
    mkdir -p $out/share/icons
    tar xzf ./Source/arcs/Icon_Wallbash.tar.gz -C $out/share/icons

    # BUILD GTK THEME
    mkdir -p $out/share/themes
    tar xzf ./Source/arcs/Gtk_Wallbash.tar.gz -C $out/share/themes

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out
    cp -r . $out

    runHook postInstall
  '';

  postInstall = ''
    wrapProgram $out/Configs/.local/bin/hyde-shell \
      --prefix PATH : "${pkgs.lib.makeBinPath [pkgs.python3]}" \
      --prefix PYTHONPATH : "${pkgs.python3.pkgs.makePythonPath [pkgs.pyamdgpuinfo]}" \
  '';

  meta = {
    description = "HyDE, your Development Environment";
    homepage = "https://github.com/HyDE-Project/HyDE";
    license = lib.licenses.gpl3Only;
    maintainers = [];
    platforms = lib.platforms.all;
  };
}
