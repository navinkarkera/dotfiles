# Copyright (c) 2010 Aldo Cortesi
# Copyright (c) 2010, 2014 dequis
# Copyright (c) 2012 Randall Ma
# Copyright (c) 2012-2014 Tycho Andersen
# Copyright (c) 2012 Craig Barnes
# Copyright (c) 2013 horsik
# Copyright (c) 2013 Tao Sauvage
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

import os
import subprocess

from libqtile import bar, hook, layout, qtile, widget
from libqtile.config import Click, Drag, DropDown, Group, Key, KeyChord, Match, ScratchPad, Screen
from libqtile.extension import CommandSet
from libqtile.lazy import lazy
from libqtile.widget import backlight

mod = 'mod4'
alt = 'mod1'
ctrl = 'control'
terminal = 'kitty'
floating_terminal = terminal + ' --class floating.terminal '
browser = 'firefox-developer-edition'
menu = 'rofi -modi drun -show drun -config ~/.config/rofi/rofidmenu.rasi'
dmenu = 'dmenu_run'

keys = [
    # A list of available commands that can be bound to keys can be found
    # at https://docs.qtile.org/en/latest/manual/config/lazy.html
    # Switch between windows
    Key([mod], 'h', lazy.layout.left(), desc='Move focus to left'),
    Key([mod], 'l', lazy.layout.right(), desc='Move focus to right'),
    Key([mod], 'j', lazy.layout.down(), desc='Move focus down'),
    Key([mod], 'k', lazy.layout.up(), desc='Move focus up'),
    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key([mod, 'shift'], 'h', lazy.layout.shuffle_left(), desc='Move window to the left'),
    Key([mod, 'shift'], 'l', lazy.layout.shuffle_right(), desc='Move window to the right'),
    Key([mod, 'shift'], 'j', lazy.layout.shuffle_down(), desc='Move window down'),
    Key([mod, 'shift'], 'k', lazy.layout.shuffle_up(), desc='Move window up'),
    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key(
        [],
        'XF86MonBrightnessUp',
        lazy.widget['backlight'].change_backlight(backlight.ChangeDirection.UP),
    ),
    Key([], 'XF86MonBrightnessDown', lazy.widget['backlight'].change_backlight(backlight.ChangeDirection.DOWN)),
    Key(
        [],
        'XF86AudioRaiseVolume',
        lazy.widget['volume'].increase_vol(),
    ),
    Key(
        [],
        'XF86AudioLowerVolume',
        lazy.widget['volume'].decrease_vol(),
    ),
    Key(
        [],
        'XF86AudioMute',
        lazy.widget['volume'].mute(),
    ),
    KeyChord(
        [mod],
        'r',
        [
            Key([], 'i', lazy.layout.grow(), desc='Grow window in monad layout'),
            Key([], 'd', lazy.layout.shrink(), desc='Shrink window in monad layout'),
            Key([], 'r', lazy.layout.reset(), desc='Reset window in monad layout'),
            Key([], 'h', lazy.layout.grow_left(), desc='Grow window to the left'),
            Key([], 'l', lazy.layout.grow_right(), desc='Grow window to the right'),
            Key([], 'j', lazy.layout.grow_down(), desc='Grow window down'),
            Key([], 'k', lazy.layout.grow_up(), desc='Grow window up'),
            Key([], 'm', lazy.layout.maximize(), desc='Grow to maximum size in monad layout'),
            Key([], 'n', lazy.layout.normalize(), desc='Reset all window sizes'),
        ],
    ),
    KeyChord(
        [mod, 'shift'],
        'm',
        [
            Key([], 'l', lazy.layout.move_window_to_next_split(), desc='Move window to next split'),
        ],
    ),
    # Applications
    KeyChord(
        [mod],
        'a',
        [
            Key([], 'b', lazy.spawn(browser), desc='Launch browser'),
            Key([], 'd', lazy.spawn(menu), desc='Launch menu'),
            Key([], 'f', lazy.spawn('thunar'), desc='Launch file browser'),
            Key(
                [],
                'j',
                lazy.run_extension(
                    CommandSet(
                        commands={
                            'Current tasks': 'kitty --class floating.terminal -e jira issue list -a navinkarkera -R unresolved -s~Recurring -s~Archived --updated -14d --jql "sprint in openSprints()"',
                            'Current reviews': """kitty --class floating.terminal -e jira issue list -R unresolved --jql 'sprint in openSprints() and ("Reviewer 1"=currentuser() OR "Reviewer 2"=currentuser())'""",
                            'Future tasks': 'kitty --class floating.terminal -e jira issue list -a navinkarkera -R unresolved --jql "sprint in futureSprints() and status != Done"',
                            'Future Unassigned tasks': """ kitty --class floating.terminal -e jira issue list -ax -R unresolved --jql 'sprint in futureSprints() and sprint != "Last resort - Accepted" and sprint != "Last resort - Proposed"' """,
                        },
                        dmenu_lines=10,
                    )
                ),
                desc='Jira tasks',
            ),
            Key(
                [],
                'w',
                lazy.run_extension(
                    CommandSet(
                        commands={
                            'Nightly tutor': 'kitty --session ~/.config/kitty/sessions/nightly-tutor.conf --detach',
                            'Redwood tutor': 'kitty --session ~/.config/kitty/sessions/redwood-tutor.conf --detach',
                        },
                        dmenu_lines=10,
                    )
                ),
                desc='Jira tasks',
            ),
        ],
    ),
    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key(
        [mod, 'shift'],
        'Tab',
        lazy.next_layout(),
        desc='Next layout',
    ),
    Key([mod, 'shift'], 'Return', lazy.spawn(terminal), desc='Launch terminal'),
    Key([mod, 'shift'], 'd', lazy.spawn(dmenu), desc='Launch menu'),
    # Toggle between different layouts as defined below
    Key([mod], 'Tab', lazy.screen.toggle_group(), desc='Toggle last screen'),
    Key([alt], 'Tab', lazy.group.next_window(), desc='Toggle between windows'),
    Key([mod], 'q', lazy.window.kill(), desc='Kill focused window'),
    Key([mod, 'control'], 'l', lazy.spawn('i3lock')),
    Key(
        [mod],
        'f',
        lazy.window.toggle_fullscreen(),
        desc='Toggle fullscreen on the focused window',
    ),
    Key([mod, 'control'], 'r', lazy.reload_config(), desc='Reload the config'),
    Key([mod, 'control'], 'q', lazy.shutdown(), desc='Shutdown Qtile'),
    Key([mod], 'Return', lazy.group['0'].dropdown_toggle('terminal'), desc='Open scratch terminal'),
    Key([mod], 'n', lazy.group['0'].dropdown_toggle('notes'), desc='Open notes'),
    Key([mod], 'm', lazy.group['0'].dropdown_toggle('mail'), desc='Open mail'),
    Key([mod], 't', lazy.group['0'].dropdown_toggle('taskwarrior'), desc='Open taskwarrior'),
    Key([mod], 'g', lazy.group['0'].dropdown_toggle('taskwarrior-github'), desc='Open taskwarrior github'),
    Key([mod, 'shift'], 'm', lazy.group['0'].dropdown_toggle('taskwarrior-maintainer'), desc='Open taskwarrior github'),
    Key([mod, 'control'], 't', lazy.group['0'].dropdown_toggle('timer'), desc='Start and log time'),
    Key([mod], 'b', lazy.group['0'].dropdown_toggle('btop'), desc='Show btop'),
    Key([mod, 'shift'], 'f', lazy.group['0'].dropdown_toggle('filemanager'), desc='Show yazi filemanager'),
    Key([mod, 'shift'], 'p', lazy.spawn('passmenu --type'), desc='Password manager in type mode'),
]


# Add key bindings to switch VTs in Wayland.
# We can't check qtile.core.name in default config as it is loaded before qtile is started
# We therefore defer the check until the key binding is run by using .when(func=...)
for vt in range(1, 8):
    keys.append(
        Key(
            ['control', 'mod1'],
            f'f{vt}',
            lazy.core.change_vt(vt).when(func=lambda: qtile.core.name == 'wayland'),
            desc=f'Switch to VT{vt}',
        )
    )

scratchpad_group = [
    ScratchPad(
        '0',
        [
            DropDown(
                'terminal',
                [terminal],
                height=0.7,
                width=0.8,
                x=0.1,
                y=0.0,
                on_focus_lost_hide=True,
                opacity=0.85,
                warp_pointer=False,
            ),
            DropDown(
                'notes',
                [terminal, '-d', '~/Documents/notes/', '-e', 'zk', 'edit', '-s', 'modified', '-i'],
                height=0.7,
                width=0.8,
                x=0.1,
                y=0.0,
                on_focus_lost_hide=True,
                opacity=0.85,
                warp_pointer=False,
            ),
            DropDown(
                'mail',
                [terminal, '-T', 'Email', '-e', 'neomutt'],
                height=0.8,
                width=0.8,
                x=0.1,
                y=0.0,
                on_focus_lost_hide=True,
                opacity=0.85,
                warp_pointer=False,
            ),
            DropDown(
                'taskwarrior',
                [terminal, '-T', 'Tasks', '-e', 'vit'],
                height=0.8,
                width=0.8,
                x=0.1,
                y=0.0,
                on_focus_lost_hide=True,
                opacity=0.85,
                warp_pointer=False,
            ),
            DropDown(
                'taskwarrior-github',
                [terminal, '-T', 'Tasks', '-e', 'vit', 'github'],
                height=0.8,
                width=0.8,
                x=0.1,
                y=0.0,
                on_focus_lost_hide=True,
                opacity=0.85,
                warp_pointer=False,
            ),
            DropDown(
                'taskwarrior-maintainer',
                [terminal, '-T', 'Tasks', '-e', 'vit', 'maintainer'],
                height=0.8,
                width=0.8,
                x=0.1,
                y=0.0,
                on_focus_lost_hide=True,
                opacity=0.85,
                warp_pointer=False,
            ),
            DropDown(
                'timer',
                [terminal, '-e', 'twc'],
                height=0.7,
                width=0.5,
                x=0.25,
                y=0.0,
                on_focus_lost_hide=True,
                opacity=0.85,
                warp_pointer=False,
            ),
            DropDown(
                'btop',
                [terminal, '-e', 'btop'],
                height=0.8,
                width=0.8,
                x=0.1,
                y=0.0,
                on_focus_lost_hide=True,
                opacity=0.85,
                warp_pointer=False,
            ),
            DropDown(
                'filemanager',
                [terminal, '-e', 'yazi'],
                height=0.8,
                width=0.8,
                x=0.1,
                y=0.0,
                on_focus_lost_hide=True,
                opacity=0.85,
                warp_pointer=False,
            ),
        ],
        single=False,
    )
]

groups_screen_1 = [Group(i, screen_affinity=1) for i in '12345']
groups_screen_2 = [Group(i, screen_affinity=0) for i in '6789']
groups = scratchpad_group + groups_screen_1 + groups_screen_2


def go_to_group(name: str):
    def _inner(qtile):
        if len(qtile.screens) == 1:
            qtile.groups_map[name].toscreen()
            return

        if name in '12345':
            qtile.focus_screen(1)
            qtile.groups_map[name].toscreen()
        else:
            qtile.focus_screen(0)
            qtile.groups_map[name].toscreen()

    return _inner


def go_to_group_and_move_window(name: str):
    def _inner(qtile):
        if len(qtile.screens) == 1:
            qtile.current_window.togroup(name, switch_group=True)
            return

        if name in '12345':
            qtile.current_window.togroup(name, switch_group=False)
            qtile.focus_screen(1)
            qtile.groups_map[name].toscreen()
        else:
            qtile.current_window.togroup(name, switch_group=False)
            qtile.focus_screen(0)
            qtile.groups_map[name].toscreen()

    return _inner


for i in groups:
    keys.append(Key([mod], i.name, lazy.function(go_to_group(i.name))))
    keys.extend(
        [
            # mod + group number = switch to group
            Key(
                [mod],
                i.name,
                lazy.function(go_to_group(i.name)),
                desc=f'Switch to group {i.name}',
            ),
            # mod + shift + group number = switch to & move focused window to group
            Key(
                [mod, 'shift'],
                i.name,
                lazy.function(go_to_group_and_move_window(i.name)),
                desc=f'Switch to & move focused window to group {i.name}',
            ),
            # Or, use below if you prefer not to switch to that group.
            # # mod + shift + group number = move focused window to group
            # Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
            #     desc="move focused window to group {}".format(i.name)),
        ]
    )

colors = [
    ['#1f2428', '#1d2428'],
    ['#1c1f24', '#1c1f24'],
    ['#dfdfdf', '#dfdfdf'],
    ['#ff6c6b', '#ff6c6b'],
    ['#5f875f', '#5f875f'],
    ['#000000', '#000000'],
    ['#51afef', '#51afef'],
    ['#259ec1', '#259ec1'],
    ['#46d9ff', '#46d9ff'],
    ['#1f5b70', '#1f5b70'],
    ['#d84949', '#d84949'],
    ['#008080', '#008080'],
]

default_layout_params = {'border_focus': colors[8][1], 'border_width': 1, 'single_border_width': 0}

layouts = [
    layout.MonadTall(ratio=0.6, **default_layout_params),
    layout.Columns(
        initial_ratio=1.2,
        split=False,
        **default_layout_params
    ),
    layout.MonadWide(ratio=0.7, **default_layout_params),
    # layout.Stack(num_stacks=2),
    layout.Max(),
    layout.ScreenSplit(splits=[
        {'layout': layout.Max(), 'name': 'left', 'rect': (0.5, 0, 0.5, 1)},
        {'layout': layout.Columns(), 'name': 'right', 'rect': (0, 0, 0.5, 1)},
    ]),
    # Try more layouts by unleashing below layouts.
    # layout.Bsp(),
    # layout.Matrix(),
    # layout.RatioTile(),
    # layout.Tile(),
    # layout.TreeTab(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
]

widget_defaults = dict(font='sans', fontsize=16, padding=3, background=colors[1])
extension_defaults = widget_defaults.copy()
groupbox1 = widget.GroupBox(visible_groups=['1', '2', '3', '4', '5'])
groupbox2 = widget.GroupBox(visible_groups=['6', '7', '8', '9', '0'])


@hook.subscribe.screens_reconfigured
async def _():
    if len(qtile.screens) > 1:
        groupbox1.visible_groups = ['1', '2', '3', '4', '5']
        groupbox1.visible_groups = ['6', '7', '8', '9', '0']
    else:
        groupbox1.visible_groups = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '0']
    if hasattr(groupbox1, 'bar'):
        groupbox1.bar.draw()
    if hasattr(groupbox2, 'bar'):
        groupbox2.bar.draw()


def get_screen(show_systray=True):
    widgets = [
        widget.CurrentLayout(),
        widget.GroupBox(
            margin_y=3,
            margin_x=0,
            padding_y=5,
            padding_x=3,
            borderwidth=3,
            rounded=False,
            active=colors[2],
            inactive=colors[11],
            highlight_color=colors[1],
            highlight_method='line',
            this_current_screen_border=colors[10],
            this_screen_border=colors[10],
            other_current_screen_border=colors[6],
            other_screen_border=colors[10],
            foreground=colors[2],
            background=colors[0],
        ),
        widget.Prompt(),
        widget.WindowName(),
        widget.Chord(
            chords_colors={
                'launch': ('#ff0000', '#ffffff'),
            },
            name_transform=lambda name: name.upper(),
        ),
        widget.Volume(emoji=False),
        widget.Battery(foreground='#f09ff6'),
        widget.ThermalSensor(tag_sensor='Package id 0'),
        widget.GenPollCommand(
            cmd='~/.config/i3/scripts/timewarrior-status', update_interval=1, shell=True, foreground='#fff986'
        ),
        # NB Systray is incompatible with Wayland, consider using StatusNotifier instead
        # widget.StatusNotifier(),
        widget.Backlight(
            backlight_name='nvidia_wmi_ec_backlight', change_command='brightnessctl s {0}%', foreground='#4ff4ff'
        ),
        widget.Clock(format='%Y-%m-%d %a %I:%M %p', foreground='#fff986'),
    ]
    if show_systray:
        widgets.append(widget.Systray())
    return Screen(
        bottom=bar.Bar(
            widgets,
            24,
            # border_width=[2, 0, 2, 0],  # Draw top and bottom borders
            # border_color=["ff00ff", "000000", "ff00ff", "000000"]  # Borders are magenta
        ),
    )


screens = [get_screen(), get_screen(False)]

# Drag floating layouts.
mouse = [
    Drag([mod], 'Button1', lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], 'Button3', lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], 'Button2', lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
floats_kept_above = True
cursor_warp = False
floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class='confirmreset'),  # gitk
        Match(wm_class='makebranch'),  # gitk
        Match(wm_class='maketag'),  # gitk
        Match(wm_class='ssh-askpass'),  # ssh-askpass
        Match(wm_class='floating.terminal'),  # specific floating terminal
        Match(title='branchdialog'),  # gitk
        Match(title='pinentry'),  # GPG key password entry
    ]
)
auto_fullscreen = True
focus_on_window_activation = 'smart'
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None

# xcursor theme (string or None) and size (integer) for Wayland backend
wl_xcursor_theme = None
wl_xcursor_size = 24

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = 'LG3D'


@hook.subscribe.startup_once
def autostart():
    script = os.path.expanduser('~/.config/qtile/autostart.sh')
    subprocess.run([script])
