{ pkgs, ... }:

{
  programs.fastfetch = {
    enable = true;

    settings = {
      logo = {
        type = "none";
      };

      display = {
        separator = " ";
        color = "#c6a0f6";
      };

      modules = [
        {
          type = "custom";
          format = "─────────────────────────────────";
        }
        {
          type = "title";
          keyWidth = 10;
        }
        {
          type = "custom";
          format = "─────────────────────────────────";
        }
        "break"
        {
          type = "custom";
          key = "System";
          keyColor = "#ed8796";
          format = "";
        }
        {
          type = "os";
          key = "├ 💾";
          keyColor = "#ed8796";
        }
        {
          type = "kernel";
          key = "├ 🐧";
          keyColor = "#ed8796";
        }
        {
          type = "packages";
          key = "├ 📦";
          keyColor = "#ed8796";
        }
        {
          type = "initsystem";
          key = "├ ⏱️";
          keyColor = "#ed8796";
        }
        {
          type = "shell";
          key = "└ 🐚";
          keyColor = "#ed8796";
        }
        "break"
        {
          type = "custom";
          key = "Client";
          keyColor = "#f5a97f";
          format = "";
        }
        {
          type = "lm";
          key = "├ 🚪";
          keyColor = "#f5a97f";
        }
        {
          type = "wm";
          key = "├ 🦟";
          keyColor = "#f5a97f";
        }
        {
          type = "de";
          key = "├ 🖥";
          keyColor = "#f5a97f";
        }
        {
          type = "terminal";
          key = "├ 🮮";
          keyColor = "#f5a97f";
        }
        {
          type = "theme";
          key = "├ 🎨";
          keyColor = "#f5a97f";
        }
        {
          type = "icons";
          key = "├ 📁";
          keyColor = "#f5a97f";
        }
        {
          type = "cursor";
          key = "├ 🖱";
          keyColor = "#f5a97f";
        }
        {
          type = "font";
          key = "└ 🖤";
          keyColor = "#f5a97f";
        }
        "break"
        {
          type = "custom";
          key = "Hardware";
          keyColor = "#a6da95";
          format = "";
        }
        {
          type = "host";
          key = "├ 🧩";
          keyColor = "#a6da95";
        }
        {
          type = "cpu";
          key = "├ 🧠";
          keyColor = "#a6da95";
        }
        {
          type = "gpu";
          key = "├ ⚙️";
          keyColor = "#a6da95";
        }
        {
          type = "memory";
          key = "├ 📚";
          keyColor = "#a6da95";
        }
        {
          type = "custom";
          key = "├ 📁";
          keyColor = "#a6da95";
        }
        {
          type = "disk";
          key = "│ └";
          keyColor = "#a6da95";
        }
        {
          type = "chassis";
          key = "└ 📦";
          keyColor = "#a6da95";
        }
        "break"
        {
          type = "custom";
          key = "Peripherals";
          keyColor = "#8aadf4";
          format = "";
        }
        {
          type = "custom";
          key = "├ 🖥";
          keyColor = "#8aadf4";
          format = "";
        }
        {
          type = "display";
          key = "│ └";
          keyColor = "#8aadf4";
        }
        {
          type = "custom";
          key = "├ 🖱";
          keyColor = "#8aadf4";
          format = "";
        }
        {
          type = "mouse";
          key = "│ └";
          keyColor = "#8aadf4";
        }
        {
          type = "custom";
          key = "├ 🎮";
          keyColor = "#8aadf4";
          format = "";
        }
        {
          type = "gamepad";
          key = "│ └";
          keyColor = "#8aadf4";
        }
        {
          type = "sound";
          key = "├ 🔈";
          keyColor = "#8aadf4";
        }
        {
          type = "camera";
          key = "└ 📷";
          keyColor = "#8aadf4";
        }
      ];
    };
  };

  home.packages = with pkgs; [
    fastfetch
  ];
}
