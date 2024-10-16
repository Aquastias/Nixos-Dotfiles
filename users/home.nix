{ pkgs, ... }:

{
  home = {
    enableNixpkgsReleaseCheck = false;

    # This value determines the Home Manager release that your configuration is
    # compatible with. This helps avoid breakage when a new Home Manager release
    # introduces backwards incompatible changes.
    #
    # You should not change this value, even if you update Home Manager. If you do
    # want to update the value, then make sure to first check the Home Manager
    # release notes.
    stateVersion = "24.05";
  };

  programs = {
    # Let Home Manager install and manage itself.
    home-manager = {
      enable = true;
    };

    git = {
      enable = true;
      extraConfig = {
        init.defaultBranch = "main";
        safe.directory = "/etc/nixos";
      };
    };

    firefox = {
      enable = true;
    };

    # VSCode
    vscode = {
      enable = true;
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
            markdownAllInOne = vscodeExtensions.yzhang.markdown-all-in-one;
            nixfmt = vscodeExtensions.brettm12345.nixfmt-vscode;
            nixIde = vscodeExtensions.jnoortheen.nix-ide;
            prettier = vscodeExtensions.esbenp.prettier-vscode;
            projectManager = vscodeExtensions.alefragnani.project-manager;
            rust = vscodeExtensions.rust-lang.rust-analyzer;
            spellChecker = vscodeExtensions.streetsidesoftware.code-spell-checker;
            svg = vscodeExtensions.jock.svg;
            vim = vscodeExtensions.vscodevim.vim;
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
        "editor.formatOnSave" = true;
        "editor.formatOnPaste" = false;
        "editor.fontFamily" = "Fira Code";
        "editor.fontSize" = 12;
        "editor.fontLigatures" = true;
        "editor.formatOnType" = false;
        "editor.insertSpaces" = true;
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
      };
    };
  };

}
