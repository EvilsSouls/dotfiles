if status is-interactive
    # Commands to run in interactive sessions can go here

    # Run Fastfetch at the start and add a newline
    fastfetch --config ~/.config/fastfetch/minimal_config.jsonc
end

# Initialize Starship
function starship_transient_prompt_func
   starship module character
end
starship init fish | source
enable_transience

# Set up fzf key bindings
fzf --fish | source

# --- Set all Aliases ---

# Alias the ls command to instead use eza
alias ls="eza --hyperlink"
abbr --add l ls -l
abbr --add lt ls --tree
set -gx EZA_ICONS_AUTO

# Alias the vim command to instead use nvim
alias vim="nvim"

set -x THEFUCK_OVERRIDDEN_ALIASES 'ls,vim'

# Alias Wiki-Tui command to 'wk' for English Wikipedia and 'wkd' for German Wikipedia
abbr --add wk wiki-tui
abbr --add wkd wiki-tui -l de

# Set default Editor to Neovim
set -gx EDITOR nvim

# Set the fish greeting to a new line
set -g fish_greeting \n

# Initialize Zoxide
zoxide init --cmd cd fish | source

# Created by `pipx` on 2025-08-02 21:14:22
set PATH $PATH /home/evilssouls/.local/bin
