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

# Alias the ls command to instead use lsd
alias ls="lsd"

# Alias the vim command to instead use nvim
alias vim="nvim"

set -x THEFUCK_OVERRIDDEN_ALIASES 'ls,vim'


# Set default Editor to Neovim
set -gx EDITOR nvim

# Set the fish greeting to a new line
set -g fish_greeting \n

# Initialize Zoxide
zoxide init --cmd cd fish | source

# Created by `pipx` on 2025-08-02 21:14:22
set PATH $PATH /home/evilssouls/.local/bin
