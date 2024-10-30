{
  specialArgs,
  configVars,
  ...
}: {
  programs.vscode.userSettings = let
    inherit (specialArgs) hostName;
    inherit (configVars) flake;
  in {
    "[nix]" = {
      "editor.defaultFormatter" = "jnoortheen.nix-ide";
    };
    "[javascript, javascriptreact, typescript, typescriptreact]" = {
      "editor.codeActionsOnSave" = {
        "source.fixAll.eslint" = true;
      };
      "editor.defaultFormatter" = "esbenp.prettier-vscode";
    };
    "[json, jsonc]" = {
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
    "cSpell.enableFiletypes" = [];
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
    "nix.serverPath" = "nixd";
    "nix.serverSettings" = {
      "nixd" = {
        "formatting" = {
          "command" = ["alejandra"];
        };
        "options" = {
          "nixos" = {
            "expr" = "(builtins.getFlake \"${flake.path}\").nixosConfigurations.\"${hostName}\".options";
          };
        };
      };
      "nixpkgs" = {
        "expr" = "import (builtins.getFlake \"${flake.path}\").inputs.nixpkgs { }";
      };
    };
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
        "after" = ["<Esc>"];
      }
    ];
    "vim.normalModeKeyBindings" = [
      {
        "before" = ["<C-n>"];
        "commands" = [":nohl"];
      }
      {
        "before" = [
          "leader"
          "w"
        ];
        "commands" = ["workbench.action.files.save"];
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
        "before" = [">"];
        "commands" = ["editor.action.indentLines"];
      }
      {
        "before" = ["<"];
        "commands" = ["editor.action.outdentLines"];
      }
    ];
    "vim.visualModeKeyBindingsNonRecursive" = [
      {
        "before" = ["p"];
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
}
