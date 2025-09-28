abbr -a !! --position anywhere --function last_history_item
abbr --add dotdot --position anywhere --regex '^\.\.+$' --function expand_dots

# --- eza abbreviations ---
abbr -a l ls -l
abbr -a lt ls --tree

# --- nvim abbreviations ---
abbr -a vim nvim # Alias the vim command to instead use nvim
abbr -a v nvim

# --- bat and bat-extras abbreviations ---
abbr -a --position anywhere -- --help '--help | bat -plhelp' # Use bat for --help arguments
abbr -a --position anywhere -- -h '-h | bat -plhelp' # use bat for -h arguments
abbr -a rgb batgrep
abbr -a pbat prettybat
abbr -a lsbc 'lsblk | bat -p -l conf'

# --- wiki-tui abbreviations ---
abbr -a wk wiki-tui
abbr -a wkd wiki-tui -l de
