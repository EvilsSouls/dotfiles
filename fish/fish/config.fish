# TODO: Add more fzf keybinds, change it so that it can also display images and maybe make the changes all new fish changes its own plugin / fork another one

if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Created by `pipx` on 2025-08-02 21:14:22
set PATH $PATH /home/evilssouls/.local/bin

function fish_user_key_bindings
  bind --mode insert alt-v fish_clipboard_paste
  bind --mode normal alt-v fish_clipboard_paste
  bind --mode visual alt-c fish_clipboard_copy
end

# --- starship ---
starship init fish | source
function starship_transient_prompt_func
   starship module character
end
enable_transience

# --- fzf and fzf fish plugins ---
set -gx FZF_DEFAULT_COMMAND 'fd --max-depth 12 --strip-cwd-prefix --hidden --follow --exclude .git'
set fzf_diff_highlighter delta --paging=never --width=20
set fzf_preview_dir_cmd eza --all
set fzf_fd_opts --hidden --follow --max-depth 10

# --- eza ---
alias ls='eza --hyperlink --group-directories-first' # Alias the ls command to instead use eza
set -gx EZA_ICONS_AUTO

# --- nvim ---
set -gx EDITOR nvim # Set default editor to Neovim

# --- bat and bat-extras ---
batman --export-env | source
set -gx BATDIFF_USE_DELTA true

# --- thefuck ---
set -x THEFUCK_OVERRIDDEN_ALIASES 'ls'

# --- zoxide ---
zoxide init --cmd cd fish | source
