function fish_greeting
  fastfetch --config ~/.config/fastfetch/minimal_config.jsonc

    if set -q fish_private_mode
        echo "fish is running in private mode, history will not be persisted."
    end
end
