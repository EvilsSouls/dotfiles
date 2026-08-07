# Taken from BreadOnPenguin's Config
# Show no lsp errors due to undefined `c` and `config` variables
c = c  # pyright: ignore
config = config  # pyright: ignore

config.source('theme.py')
config.load_autoconfig()

config.bind('<Alt-Shift-u>', 'spawn --userscript qute-keepassxc --key evilssouls@protonmail.com', mode='insert')
config.bind('pw', 'spawn --userscript qute-keepassxc --key evilssouls@protonmail.com', mode='normal')

config.bind('<Shift-Alt-a>', 'config-cycle -t colors.webpage.darkmode.enabled "true" "false"')

config.bind('<Alt-Shift-j>', 'tab-move +', mode='normal')
config.bind('<Alt-Shift-k>', 'tab-move -', mode='normal')

config.bind(',m', 'spawn mpv {url}')
config.bind(',M', 'hint links spawn mpv {hint-url}')

# Make Qutebrowser more generic
c.content.headers.user_agent = 'Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0'
c.content.headers.accept_language = 'en-US,en;q=0.5'
c.content.headers.custom = {"accept": "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8"}
c.content.blocking.method = 'both'

# Insert Movement keys
config.bind('<Ctrl+h>', 'fake-key <right>', 'insert')
config.bind('<Ctrl+j>', 'fake-key <down>', 'insert')
config.bind('<Ctrl+k>', 'fake-key <up>', 'insert')
config.bind('<Ctrl+l>', 'fake-key <left>', 'insert')

# Prompt Movement keys
config.bind('<Ctrl+h>', 'rl-unix-filename-rubout', 'prompt')
config.bind('<Ctrl+j>', 'prompt-item-focus next', 'prompt')
config.bind('<Ctrl+k>', 'prompt-item-focus prev', 'prompt')

# Only show tabbar when multiple tabs are open,
# so that when using qutebrowser for typst no screen
# real estate is wasted
c.tabs.show = 'multiple'
c.scrolling.bar = 'overlay'

# Use smooth scrolling
# c.scrolling.smooth = True

# Set Transparency
c.colors.tabs.bar.bg = "rgba(0, 0, 0, 170)"

c.colors.tabs.odd.bg = "rgba(40, 40, 40, 100)"
c.colors.tabs.even.bg = "rgba(24, 24, 24, 100)"

c.colors.tabs.pinned.odd.bg = "rgba(161, 181, 108, 100)"
c.colors.tabs.pinned.even.bg = "rgba(134, 193, 185, 100)"

c.colors.tabs.pinned.selected.odd.bg = "rgba(171, 70, 66, 100)"
c.colors.tabs.pinned.selected.even.bg = "rgba(171, 70, 66, 100)"

c.colors.tabs.selected.odd.bg = "rgba(171, 70, 66, 100)"
c.colors.tabs.selected.even.bg = "rgba(171, 70, 66, 100)"

# c.colors.tabs.odd.bg = "rgba(0, 0, 0, 0)"
c.colors.statusbar.normal.bg = "rgba(0, 0, 0, 170)"
# Doesn't work due to z-index problems
#c.colors.webpage.bg = "transparent"

# Copied from BreadonPenguins config
c.url.searchengines = {
        'DEFAULT': 'http://localhost:8080/search?q={}',
        '!aw': 'https://wiki.archlinux.org/?search={}',
        '!apkg': 'https://archlinux.org/packages/?sort=&q={}&maintainer=&flagged=',
        '!gh': 'https://github.com/search?o=desc&q={}&s=stars',
        '!yt': 'https://www.youtube.com/results?search_query={}',
        }
