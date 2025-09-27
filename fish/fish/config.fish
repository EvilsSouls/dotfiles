if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Created by `pipx` on 2025-08-02 21:14:22
set PATH $PATH /home/evilssouls/.local/bin

# Configure keybindings
bind --mode insert alt-v fish_clipboard_paste
bind --mode insert alt-c fish_clipboard_copy
bind ctrl-alt-n echo_commandline

# --- transient prompt ---
# The fish plugin is used, since starship has some minor quirks in its implementation
#function transient_prompt_func
#  starship module character
#end

# --- starship ---
starship init fish | source
function starship_transient_prompt_func
   starship module character
end
enable_transience

# --- fzf ---
# TODO: Eventually change it so that the fzf keybinds also show a preview
#fzf --fish | source
abbr -a 'inv' 'nvim $(fzf -m --preview="bat -p --color=always {}")'
set -gx FZF_DEFAULT_COMMAND 'fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'
set -gx FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND

# --- eza ---
alias ls='eza --hyperlink --group-directories-first' # Alias the ls command to instead use eza
abbr -a l ls -l
abbr -a lt ls --tree
set -gx EZA_ICONS_AUTO

# --- nvim ---
set -gx EDITOR nvim # Set default editor to Neovim
abbr -a vim nvim # Alias the vim command to instead use nvim
abbr -a v nvim

# --- bat and bat-extras ---
abbr -a --position anywhere -- --help '--help | bat -plhelp' # Use bat for --help arguments
abbr -a --position anywhere -- -h '-h | bat -plhelp' # use bat for -h arguments
batman --export-env | source
abbr -a rgb batgrep
abbr -a pbat prettybat
set -gx BATDIFF_USE_DELTA true
abbr -a lsbc 'lsblk | bat -p -l conf'

# --- thefuck ---
set -x THEFUCK_OVERRIDDEN_ALIASES 'ls'

# --- wiki-tui ---
# Alias Wiki-Tui command to 'wk' for English Wikipedia and 'wkd' for German Wikipedia
abbr -a wk wiki-tui # Alias English wikipedia to wk
abbr -a wkd wiki-tui -l de # Alias German wikipedia to wkd

# --- zoxide ---
zoxide init --cmd cd fish | source
