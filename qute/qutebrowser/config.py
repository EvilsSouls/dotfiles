# Taken from BreadOnPenguin's Config
# Show no lsp errors due to undefined `c` and `config` variables
c = c  # pyright: ignore
config = config  # pyright: ignore

config.source('theme.py')
config.load_autoconfig()

config.bind('<Alt-Shift-u>', 'spawn --userscript qute-keepassxc --key evilssouls@protonmail.com', mode='insert')
config.bind('pw', 'spawn --userscript qute-keepassxc --key evilssouls@protonmail.com', mode='normal')
config.bind('<Alt-Shift-j>', 'tab-move +', mode='normal')
config.bind('<Alt-Shift-k>', 'tab-move -', mode='normal')

# Copied from BreadonPenguins config
c.url.searchengines = {
        'DEFAULT': 'http://localhost:8080/search?q={}',
        '!aw': 'https://wiki.archlinux.org/?search={}',
        '!apkg': 'https://archlinux.org/packages/?sort=&q={}&maintainer=&flagged=',
        '!gh': 'https://github.com/search?o=desc&q={}&s=stars',
        '!yt': 'https://www.youtube.com/results?search_query={}',
        }
