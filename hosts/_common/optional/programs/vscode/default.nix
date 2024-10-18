{ pkgs, ... }:

{
  programs.vscode = {
    package = pkgs.vscodium;
    mutableExtensionsDir = false;
    extensions =
      let
        vscodeExtensions = pkgs.vscode-extensions;
      in
      builtins.filter (ext: ext != null) (
        builtins.attrValues {
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
          nixfmt = vscodeExtensions.brettm12345.nixfmt-vscode;
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
    enableUpdateCheck = false;
    enableExtensionUpdateCheck = false;
    keybindings = [
      {
        "command" = "toggleVim";
        "key" = "ctrl+k ctrl+v";
      }
    ];
    userSettings = {
      "[nix]" = {
        "editor.defaultFormatter" = "jnoortheen.nix-ide";
      };
      "[javascript, javascriptreact, typescript, typescriptreact]" = {
        "editor.codeActionsOnSave" = {
          "source.fixAll.eslint" = true;
        };
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
      };
      "[php]" = {
        "editor.tabSize" = 4;
      };
      "[yaml]" = {
        "editor.autoIndent" = "advanced";
        "diffEditor.ignoreTrimWhitespace" = false;
      };
      "catppuccin.accentColor" = "mauve";
      "catppuccin.colorOverrides" = {
        "mocha" = {
          "base" = "#000000";
          "mantle" = "#010101";
          "crust" = "#020202";
        };
      };
      "catppuccin.customUIColors" = {
        "mocha" = {
          "statusBar.foreground" = "accent";
        };
      };
      "cSpell.enableFiletypes" = [ "nix" ];
      "cSpell.userWords" = [
        "esbenp"
        "pkgs"
        "stylelint"
        "Fira"
        "jnoortheen"
        "vscodevim"
        "nixpkgs"
        "treefmt"
        "nixfmt"
        "easymotion"
        "Neovim"
        "incsearch"
        "hlsearch"
        "Catppuccin"
        "builtins"
        "dbaeumer"
        "jbockle"
        "mhutchie"
        "donjayamanne"
        "githistory"
        "eamodio"
        "vincaslt"
        "sumneko"
        "yzhang"
        "brettm"
        "tomoki"
        "alefragnani"
        "timonwong"
        "shellcheck"
        "ziglang"
        "outdent"
        "nohl"
      ];
      "editor.codeActionsOnSave" = {
        "source.fixAll.stylelint" = "never";
      };
      "editor.formatOnSave" = true;
      "editor.formatOnPaste" = false;
      "editor.fontFamily" = "Fira Code";
      "editor.fontSize" = 12;
      "editor.fontLigatures" = true;
      "editor.formatOnType" = false;
      "editor.insertSpaces" = true;
      "editor.linkedEditing" = true;
      "editor.semanticHighlighting.enabled" = true;
      "editor.tabSize" = 2;
      "eslint.rules.customizations" = [
        {
          "rule" = "*";
          "severity" = "warn";
        }
      ];
      "extensions.experimental.affinity" = {
        "vscodevim.vim" = 1;
      };
      "files.autoSaveDelay" = 10000;
      "files.autoSave" = "afterDelay";
      "nix.enableLanguageServer" = true;
      "nix.serverSettings" = {
        "nil" = {
          "formatting" = {
            "command" = [ "nixfmt" ];
          };
        };
      };
      "nix.formatterPath" = [
        "nixpkgs-fmt"
        "nixfmt"
        "treefmt"
        "--stdin"
        "{file}"
        "nix"
        "fmt"
        "--"
        "-"
      ];
      "stylelint.packageManager" = "pnpm";
      "stylelint.validate" = [
        "css"
        "scss"
      ];
      "terminal.integrated.minimumContrastRatio" = 1;
      "typescript.tsdk" = "node_modules/typescript/lib";
      "vim.easymotion" = true;
      "vim.enableNeovim" = true;
      "vim.incsearch" = true;
      "vim.insertModeKeyBindings" = [
        {
          "before" = [
            "j"
            "j"
          ];
          "after" = [ "<Esc>" ];
        }
      ];
      "vim.normalModeKeyBindings" = [
        {
          "before" = [ "<C-n>" ];
          "commands" = [ ":nohl" ];
        }
        {
          "before" = [
            "leader"
            "w"
          ];
          "commands" = [ "workbench.action.files.save" ];
        }
      ];
      "vim.handleKeys" = {
        "<C-a>" = false;
        "<C-f>" = false;
        "<C-p>" = false;
      };
      "vim.hlsearch" = true;
      "vim.leader" = "<space>";
      "vim.smartRelativeLine" = true;
      "vim.surround" = true;
      "vim.useSystemClipboard" = true;
      "vim.useCtrlKeys" = true;
      "vim.visualModeKeyBindings" = [
        {
          "before" = [ ">" ];
          "commands" = [ "editor.action.indentLines" ];
        }
        {
          "before" = [ "<" ];
          "commands" = [ "editor.action.outdentLines" ];
        }
      ];
      "vim.visualModeKeyBindingsNonRecursive" = [
        {
          "before" = [ "p" ];
          "after" = [
            "p"
            "g"
            "v"
            "y"
          ];
        }
      ];
      "window.titleBarStyle" = "custom";
      "workbench.colorTheme" = "Catppuccin Mocha";
      "workbench.iconTheme" = "catppuccin-mocha";
      "workbench.sideBar.location" = "right";
      "workbench.startupEditor" = "none";
    };
  };
}
