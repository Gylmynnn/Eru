from kitty.fast_data_types import Screen, add_timer
from kitty.tab_bar import DrawData, ExtraData, TabBarData, as_rgb
from kitty.utils import color_as_int
import getpass

BG_BAR = 0x141B1E
BG_TITLE = 0x1E2528
BG_INACTIVE = 0x1A2225
FG_ACTIVE = 0xDDE1E0
FG_INACTIVE = 0x6B7D7D
BADGE_INACTIVE_BG = 0x2A3538
BADGE_INACTIVE_FG = 0x6B7D7D

_BADGE_POOL = [
    (0xE57474, 0x141B1E),  # red
    (0x67B0E8, 0x0D1315),  # blue
    (0xE5C76B, 0x141B1E),  # yellow
    (0x8CCF7E, 0x0D1315),  # green
    (0xC47FD5, 0x0D1315),  # magenta
    (0x6CBFBF, 0x0D1315),  # cyan
    (0xE57474, 0x0D1315),  # red variant
    (0x67B0E8, 0x141B1E),  # blue variant
]


def get_badge_color(proc: str):
    idx = hash(proc) % len(_BADGE_POOL)
    return _BADGE_POOL[idx]


ICON_ACTIVE = "󰮯 "
ICON_INACTIVE = "󰊠 "

CAP_LEFT = "\ue0b6"
CAP_RIGHT = "\ue0b4"

_timer_id = None


def _redraw_tab_bar(*a):
    import kitty.boss

    for tm in kitty.boss.get_boss().all_tab_managers:
        tm.tab_bar.needs_refresh = True


def _rgb(c):
    return as_rgb(color_as_int(c))


def _set(s, fg, bg):
    s.cursor.fg = _rgb(fg)
    s.cursor.bg = _rgb(bg)


def _txt(s, t):
    s.draw(t)


def get_process(title: str):
    keys = [
        "nvim",
        "vim",
        "dart",
        "flutter",
        "python",
        "python3",
        "node",
        "bash",
        "zsh",
        "fish",
        "git",
        "ssh",
        "htop",
        "btop",
        "cargo",
    ]
    t = title.lower()
    for k in keys:
        if k in t:
            return k
    return "default"


_SHELL_OPS = {"&&", "||", ";", "|", "&"}

def get_last_path(title: str) -> str:
    _home = f"{getpass.getuser()} ンタ"
    parts = title.strip().split(" ", 1)
    if len(parts) == 1:
        last = parts[0].split("/")[-1]
        return _home if last in ("~", "") else last
    arg = parts[1].strip()
    tokens = []
    for t in arg.split():
        if t in _SHELL_OPS:
            break
        if not t.startswith("-"):
            tokens.append(t)
    target = tokens[-1] if tokens else arg.split()[0]
    last = target.rstrip("/").split("/")[-1]
    if last in ("~", ""):
        return _home
    return last


def draw_tab(
    draw_data: DrawData,
    screen: Screen,
    tab: TabBarData,
    before: int,
    max_title_length: int,
    index: int,
    is_last: bool,
    extra_data: ExtraData,
) -> int:
    global _timer_id
    if _timer_id is None:
        _timer_id = add_timer(_redraw_tab_bar, 1.0, True)

    is_active = tab.is_active
    raw_title = tab.title or f"tab{index}"
    proc = get_process(raw_title)
    title = get_last_path(raw_title)

    max_t = max(12, max_title_length - 10)
    if len(title) > max_t:
        title = title[: max_t - 1] + "…"

    if is_active:
        badge_bg, badge_fg = get_badge_color(proc)

        _set(screen, badge_bg, BG_BAR)
        _txt(screen, CAP_LEFT)

        _set(screen, badge_fg, badge_bg)
        _txt(screen, f"{ICON_ACTIVE}")

        _set(screen, FG_ACTIVE, BG_TITLE)
        _txt(screen, f" {title} ")

        _set(screen, BG_TITLE, BG_BAR)
        _txt(screen, CAP_RIGHT)

    else:
        _set(screen, BADGE_INACTIVE_BG, BG_BAR)
        _txt(screen, CAP_LEFT)

        _set(screen, BADGE_INACTIVE_FG, BADGE_INACTIVE_BG)
        _txt(screen, f"{ICON_INACTIVE}")

        _set(screen, FG_INACTIVE, BG_INACTIVE)
        _txt(screen, f" {title} ")

        _set(screen, BG_INACTIVE, BG_BAR)
        _txt(screen, CAP_RIGHT)

    _set(screen, BG_BAR, BG_BAR)
    _txt(screen, " ")
    return screen.cursor.x
