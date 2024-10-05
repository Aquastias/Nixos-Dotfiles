{
  config,
  configVars,
  pkgs,
  ...
}:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = configVars.username;
  home.homeDirectory = "/home/${configVars.username}";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.
  home.enableNixpkgsReleaseCheck = false;

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = builtins.attrValues { inherit (pkgs) neovim; };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/aquastias/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Git
  programs.git = {
    enable = true;
    userName = "${configVars.username}";
    userEmail = "${configVars.gitHubEmail}";
    extraConfig = {
      init.defaultBranch = "main";
      safe.directory = "/etc/nixos";
    };
  };

  # VSCode
  programs.vscode = {
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
      "editor.formatOnPaste" = true;
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
}
