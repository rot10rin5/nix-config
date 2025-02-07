{ lib, pkgs, config, ... }:

{  
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      monitor = ", preferred, auto, auto";
       
      "$terminal" = "kitty";
      "$fileManager" = "dolphin";
      "$menu" = "rofi -show run";
      "$webBrowser" = "librewolf";
      "$screenshot" = "grim";

      env = [
        "XCURSOR_SIZE,24"
        "QT_QPA_PLATFORMTHEME,qt5ct"
      ];
       
      input = {
        kb_layout = "us, th";
        kb_options = "grp:win_space_toggle";

        follow_mouse = 1;

        touchpad = {
          natural_scroll = "no";
        };

        sensitivity = 0;

      };

      dwindle = {
        pseudotile = "yes";
        preserve_split = "yes";
      };
       
      master = {
        new_status = "master";
      };

      gestures = {
        workspace_swipe = "off";
      };

      device = {
        name = "epic-mouse-v1";
        sensitivity = -0.5;
      };

      windowrulev2 = "suppressevent maximize, class:.*";

      "$mainMod" = "SUPER";

      bind = [
        "$mainMod, Q, exec, $terminal"
        "$mainMod, C, killactive"
        "$mainMod, M, exit"
        "$mainMod, E, exec, $fileManager"
        "$mainMod, V, togglefloating"
        "$mainMod, R, exec, $menu"
        "$mainMod, P, pseudo"
        "$mainMod, J, togglesplit"
        "$mainMod, W, exec, $webBrowser"
        "$mainMod, F, fullscreen"
	"$mainMod, H, exec, $screenshot"

        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"

        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"

        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
      ];

      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      exec-once = "bash ~/nix-config/start.sh";
    };
  };
}
