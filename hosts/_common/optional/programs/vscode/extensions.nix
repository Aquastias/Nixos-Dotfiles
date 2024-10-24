{pkgs, ...}: {
  programs.vscode.extensions = let
    vscodeExtensions = pkgs.vscode-extensions;
  in
    builtins.filter (ext: ext != null) (
      builtins.attrValues {
        alejandra = vscodeExtensions.kamadorueda.alejandra;
        catppuccinTheme = vscodeExtensions.catppuccin.catppuccin-vsc;
        catppuccinThemeIcons = vscodeExtensions.catppuccin.catppuccin-vsc-icons;
        eslint = vscodeExtensions.dbaeumer.vscode-eslint;
        formatFiles = vscodeExtensions.jbockle.jbockle-format-files;
        go = vscodeExtensions.golang.go;
        gitGraph = vscodeExtensions.mhutchie.git-graph;
        gitHistory = vscodeExtensions.donjayamanne.githistory;
        gitLens = vscodeExtensions.eamodio.gitlens;
        highlightMatchingTag = vscodeExtensions.vincaslt.highlight-matching-tag;
        importCost = vscodeExtensions.wix.vscode-import-cost;
        lua = vscodeExtensions.sumneko.lua;
        markdownAllInOne = vscodeExtensions.yzhang.markdown-all-in-one;
        nixIde = vscodeExtensions.jnoortheen.nix-ide;
        pdfViewer = vscodeExtensions.tomoki1207.pdf;
        prettier = vscodeExtensions.esbenp.prettier-vscode;
        projectManager = vscodeExtensions.alefragnani.project-manager;
        rust = vscodeExtensions.rust-lang.rust-analyzer;
        shellCheck = vscodeExtensions.timonwong.shellcheck;
        spellChecker = vscodeExtensions.streetsidesoftware.code-spell-checker;
        styleLint = vscodeExtensions.stylelint.vscode-stylelint;
        svg = vscodeExtensions.jock.svg;
        vim = vscodeExtensions.vscodevim.vim;
        yaml = vscodeExtensions.redhat.vscode-yaml;
        zig = vscodeExtensions.ziglang.vscode-zig;
      }
    );
}
