# delta.yazi

A plugin for the [Yazi](https://github.com/sxyazi/yazi) file manager to compare two files together using [delta](https://github.com/dandavison/delta).

> [!NOTE]
> This is currently a plugin and not a normal opener, as Yazi sadly currently does not support having openers specifically for a selection of multiple files. Otherwise I would create a custom opener for a selection of two files.

## Credits

The code for this plugin was basically stolen from [this different Diff plugin](https://github.com/yazi-rs/plugins/blob/main/diff.yazi/main.lua) and [the builtin Zoxide plugin](https://github.com/sxyazi/yazi/blob/main/yazi-plugin/preset/plugins/zoxide.lua), as I have never written Lua code.
