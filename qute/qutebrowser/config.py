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
c.content.canvas_reading = False
c.content.webgl = False
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

# Set Transparency
c.colors.tabs.bar.bg = "#000000AA"
c.colors.statusbar.normal.bg = "#000000AA"
c.colors.webpage.bg = "transparent"

# Copied from BreadonPenguins config
c.url.searchengines = {
        'DEFAULT': 'http://localhost:8080/search?q={}',
        '!aw': 'https://wiki.archlinux.org/?search={}',
        '!apkg': 'https://archlinux.org/packages/?sort=&q={}&maintainer=&flagged=',
        '!gh': 'https://github.com/search?o=desc&q={}&s=stars',
        '!yt': 'https://www.youtube.com/results?search_query={}',
        }
