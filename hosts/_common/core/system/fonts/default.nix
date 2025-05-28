{pkgs, ...}: {
  fonts = {
    enableGhostscriptFonts = true;
    fontDir.enable = true;
    packages = builtins.attrValues {
      inherit
        (pkgs)
        corefonts
        cascadia-code
        inconsolata
        fira
        fira-mono
        fira-code
        dejavu_fonts
        libertine
        ubuntu_font_family
        noto-fonts
        noto-fonts-cjk-sans
        source-code-pro
        ;
    };
  };
}
