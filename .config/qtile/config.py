    
#       █████████     ███████    ███████████ █████ █████ ███████████ █████ █████       ██████████
#      ███░░░░░███  ███░░░░░███ ░█░░░░░░███ ░░███ ░░███ ░█░░░███░░░█░░███ ░░███       ░░███░░░░░█
#     ███     ░░░  ███     ░░███░     ███░   ░░███ ███  ░   ░███  ░  ░███  ░███        ░███  █ ░ 
#    ░███         ░███      ░███     ███      ░░█████       ░███     ░███  ░███        ░██████   
#    ░███         ░███      ░███    ███        ░░███        ░███     ░███  ░███        ░███░░█   
#    ░░███     ███░░███     ███   ████     █    ░███        ░███     ░███  ░███      █ ░███ ░   █
#     ░░█████████  ░░░███████░   ███████████    █████       █████    █████ ███████████ ██████████
#      ░░░░░░░░░     ░░░░░░░    ░░░░░░░░░░░    ░░░░░       ░░░░░    ░░░░░ ░░░░░░░░░░░ ░░░░░░░░░░ 
#
#                                                                                    - DARKKAL44
  


from libqtile import bar, layout, widget, hook, qtile
from libqtile.config import Click, Drag, Group, Key, Match, hook, Screen, KeyChord
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal
from libqtile.dgroups import simple_key_binder
from time import sleep

mod = "mod4"
terminal = "alacritty"

# █▄▀ █▀▀ █▄█ █▄▄ █ █▄░█ █▀▄ █▀
# █░█ ██▄ ░█░ █▄█ █ █░▀█ █▄▀ ▄█


def go_to_group(qtile, index):
    qtile.current_group.use_layout(index)


keys = [

#  D E F A U L T

    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "space", lazy.layout.next(), desc="Move window focus to other window"),
    Key([mod, "control"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"),
    Key([mod, "control"], "l", lazy.layout.shuffle_right(), desc="Move window to the right"),
    Key([mod, "control"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "control"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
    Key([mod, "shift"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key([mod, "shift"], "l", lazy.layout.grow_right(), desc="Grow window to the right"),
    Key([mod, "shift"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "shift"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    #Key([mod], "f", lazy.window.toggle_fullscreen()),
    Key(
        [mod, "shift"],
        "Return",
        lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack",
    ),
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "c", lazy.window.kill(), desc="Kill focused window"),
    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    Key([mod], "r", lazy.spawn("rofi -show drun"), desc="Spawn a command using a prompt widget"),
    Key([mod], "p", lazy.spawn("sh -c ~/.config/rofi/scripts/power"), desc='powermenu'),
   # Key([mod], "t", lazy.spawn("sh -c ~/.config/rofi/scripts/themes"), desc='theme_switcher'),

# C U S T O M

    Key([], "XF86AudioRaiseVolume", lazy.spawn("pactl set-sink-volume 0 +5%"), desc='Volume Up'),
    Key([], "XF86AudioLowerVolume", lazy.spawn("pactl set-sink-volume 0 -5%"), desc='volume down'),
    Key([], "XF86AudioMute", lazy.spawn("pulsemixer --toggle-mute"), desc='Volume Mute'),
    Key([], "XF86AudioPlay", lazy.spawn("playerctl play-pause"), desc='playerctl'),
    Key([], "XF86AudioPrev", lazy.spawn("playerctl previous"), desc='playerctl'),
    Key([], "XF86AudioNext", lazy.spawn("playerctl next"), desc='playerctl'),
    Key([], "XF86MonBrightnessUp", lazy.spawn("brightnessctl s 5%+"), desc='brightness UP'),
    Key([], "XF86MonBrightnessDown", lazy.spawn("brightnessctl s 5%-"), desc='brightness Down'),
    Key([mod],"e", lazy.spawn("thunar"), desc='file manager'),
	Key([mod], "h", lazy.spawn("roficlip"), desc='clipboard'),
    Key([mod], "s", lazy.spawn("brave"), desc='launch brave'),
    Key([mod, "shift"], "s", lazy.spawn("flameshot gui"), desc='Screenshot'),
    Key([mod], "t", lazy.spawn("rofi -show windowcd"), desc='window switcher'),
    Key([mod], "m", lazy.window.toggle_minimize(), desc="Toggle maximize"),
    Key([mod], "f", lazy.window.toggle_maximize(), desc="Toggle maximize"),
]



# █▀▀ █▀█ █▀█ █░█ █▀█ █▀
# █▄█ █▀▄ █▄█ █▄█ █▀▀ ▄█



groups = [Group(f"{i+1}", label="󰏃") for i in range(8)]

for i in groups:
    keys.extend(
            [
                Key(
                    [mod],
                    i.name,
                    lazy.group[i.name].toscreen(),
                    desc="Switch to group {}".format(i.name),
                    ),
                Key(
                    [mod, "shift"],
                    i.name,
                    lazy.window.togroup(i.name, switch_group=True),
                    desc="Switch to & move focused window to group {}".format(i.name),
                    ),
                ]
            )




# L A Y O U T S




layouts = [
    layout.Columns( margin= [8, 8, 8, 8], border_focus='#1F1D2E',
	    border_normal='#1F1D2E',
        border_width=0,
        fair=True,
    ),

    layout.Max(	border_focus='#1F1D2E',
	    border_normal='#1F1D2E',
	    margin=0,
	    border_width=0,
    ),

#     layout.Floating(	border_focus='#1F1D2E',
# 	    border_normal='#1F1D2E',
# 	    margin=10,
# 	    border_width=0,
# 	),
#     # Try more layouts by unleashing below layouts
#    #  layout.Stack(num_stacks=2),
#    #  layout.Bsp(),
#      layout.Matrix(	border_focus='#1F1D2E',
# 	    border_normal='#1F1D2E',
# 	    margin=10,
# 	    border_width=0,
# 	),
#      layout.MonadTall(	border_focus='#1F1D2E',
# 	    border_normal='#1F1D2E',
#         margin=10,
# 	    border_width=0,
# 	),
#     layout.MonadWide(	border_focus='#1F1D2E',
# 	    border_normal='#1F1D2E',
# 	    margin=10,
# 	    border_width=0,
# 	),
#    #  layout.RatioTile(),
#      layout.Tile(	border_focus='#1F1D2E',
# 	    border_normal='#1F1D2E',
#     ),
#    #  layout.TreeTab(),
#    #  layout.VerticalTile(),
#    #  layout.Zoomy(),
]



widget_defaults = dict(
    font="sans",
    fontsize=12,
    padding=3,
)
extension_defaults = [ widget_defaults.copy()
        ]



def search():
    qtile.cmd_spawn("rofi -show drun")

def power():
    qtile.cmd_spawn("sh -c ~/.config/rofi/scripts/power")

# █▄▄ ▄▀█ █▀█
# █▄█ █▀█ █▀▄

#purple like color='#CAA9E0'
color_bar = '#000000'
color_text= '#FF009C'

screens = [

    Screen(
        top=bar.Bar(
            [
				widget.Spacer(length=15,
                    background=color_bar,
                ),


                widget.Image(
                    filename='~/.config/qtile/Assets/launch_Icon.png',
                    margin=2,
                    background=color_bar,
                    mouse_callbacks={"Button1":power},
                ),


                widget.GroupBox(
                    fontsize=24,
                    borderwidth=3,
                    highlight_method='block',
                    active='#CAA9E0',
                    block_highlight_text_color=color_text,
                    highlight_color='#4B427E',
                    inactive='#282738',
                    foreground='#4B427E',
                    background=color_bar,
                    this_current_screen_border=color_bar,
                    this_screen_border=color_bar,
                    other_current_screen_border=color_bar,
                    other_screen_border=color_bar,
                    urgent_border=color_bar,
                    rounded=True,
                    disable_drag=True,
                 ),


                widget.Spacer(
                    length=16,
                    background=color_bar,
                ),

                widget.Image(
                    filename='~/.config/qtile/Assets/layout.png',
                    background=color_bar,
                ),


                widget.CurrentLayout(
                    background=color_bar,
                    foreground=color_text,
                    fmt='{}',
                    font="JetBrains Mono Bold",
                    fontsize=13,
                ),


                widget.Spacer(
                    length=16,
                    background=color_bar,
                ),

                widget.Image(
                    filename='~/.config/qtile/Assets/search.png',
                    margin=2,
                    background=color_bar,
                    mouse_callbacks={"Button1": search},
                ),

                widget.TextBox(
                    fmt='Search',
                    background=color_bar,
                    font="JetBrains Mono Bold",
                    fontsize=13,
                    foreground=color_text,
                    mouse_callbacks={"Button1": search},
                ),


                widget.Spacer(
                    length=32,
                    background=color_bar,
                ),


                widget.WindowName(
                    background =color_bar,
                    format = "{name}",
                    font='JetBrains Mono Bold',
                    foreground=color_text,
                    empty_group_string = 'Desktop',
                    fontsize=13,

                ),
                widget.Pomodoro(
                    background ='#250000',
                    font='JetBrains Mono Bold',
                    foreground='#FF5FDC',
                    fontsize=13,
                    color_inactive='#FF004E',
                    length_pomodori=50,
                    length_short_break=10,

                ),

                widget.Spacer(
                    length=32,
                    background=color_bar,
                ),


                widget.Systray(
                    background=color_bar,
                    fontsize=2,
                ),


                widget.TextBox(
                    text=' ',
                    background=color_bar,
                ),


                # widget.Image(
                # filename='~/.config/qtile/Assets/Drop1.png',
                # ),

                # widget.Net(
                # format=' {up}   {down} ',
                # background='#353446',
                # foreground='#CAA9E0',
                # font="JetBrains Mono Bold",
                # prefix='k',
                # ),

                # widget.Image(
                    # filename='~/.config/qtile/Assets/2.png',
                # ),

                # widget.Spacer(
                    # length=8,
                    # background='#353446',
                # ),


                widget.Image(
                    filename='~/.config/qtile/Assets/Misc/ram.png',
                    background=color_bar,
                ),


                widget.Spacer(
                    length=-7,
                    background=color_bar,
                ),


                widget.Memory(
                    background=color_bar,
                    format='{MemUsed: .0f}{mm}',
                    foreground=color_text,
                    font="JetBrains Mono Bold",
                    fontsize=13,
                    update_interval=5,
                ),

                widget.Spacer(
                    length=16,
                    background=color_bar,
                ),


                widget.BatteryIcon(
                    theme_path='~/.config/qtile/Assets/Battery/',
                    background=color_bar,
                    scale=1,
                ),


                widget.Battery(
                    font='JetBrains Mono Bold',
                    background=color_bar,
                    foreground=color_text,
                    format='{percent:2.0%}',
                    fontsize=13,
                    notification_timeout=14,
                    notify_below=10,

                ),


                widget.Spacer(
                    length=8,
                    background=color_bar,
                ),


                # widget.Battery(format=' {percent:2.0%}',
                    # font="JetBrains Mono ExtraBold",
                    # fontsize=12,
                    # padding=10,
                    # background='#353446',
                # ),

                # widget.Memory(format='﬙{MemUsed: .0f}{mm}',
                    # font="JetBrains Mono Bold",
                    # fontsize=12,
                    # padding=10,
                    # background='#4B4D66',
                # ),

                widget.Volume(
                    font='JetBrainsMono Nerd Font',
                    theme_path='~/.config/qtile/Assets/Volume/',
                    emoji=True,
                    fontsize=8,
                    background=color_bar,
                ),


                widget.Spacer(
                    length=-5,
                    background=color_bar,
                    ),


                widget.Volume(
                    font='JetBrains Mono Bold',
                    background=color_bar,
                    foreground=color_text,
                    fontsize=13,
                ),

                widget.Spacer(
                    length=6,
                    background=color_bar,
                    ),


                widget.Image(
                    filename='~/.config/qtile/Assets/Misc/clock.png',
                    background=color_bar,
                    margin_y=6,
                    margin_x=5,
                ),


                widget.Clock(
                    format='%I:%M:%S %p',
                    background=color_bar,
                    foreground=color_text,
                    font="JetBrains Mono Bold",
                    fontsize=13,
                ),

                widget.Spacer(
                    length=6,
                    background=color_bar,
                    ),

                widget.Image(
                    filename='~/.config/qtile/Assets/Misc/calendar.png',
                    background=color_bar,
                    margin_y=6,
                    margin_x=5,
                ),

                widget.Clock(
                    format='%d-%b-%y',
                    background=color_bar,
                    foreground=color_text,
                    font="JetBrains Mono Bold",
                    fontsize=13,
                ),

                widget.Spacer(
                    length=12,
                    background=color_bar,
                ),



            ],
            30,
            border_color = '#282738',
            #border_width = [0,0,0,0],
            #margin = [15,60,6,60],

        ),
    ),
]



# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(
	border_focus='#1F1D2E',
	border_normal='#1F1D2E',
	border_width=0,
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
    ]
)




from libqtile import hook
# some other imports
import os
import subprocess
# stuff
@hook.subscribe.startup_once
def autostart_once():
    home=os.path.expanduser('~/.config/qtile/autostart_once.sh')# path to my script, under my user directory
    subprocess.Popen([home])

auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"



# E O F
