# Neovim

Moving text around. This won't become a comprehensive guide, but instead a collection of things I tend to forget.

## Commands

Some commands that are useful time to time.

- `:messages`: Shows all previous messages. Can be useful to find out what happened, espcially on startup.

## Configuration Source

`nvim` can use different source of configuration with the `NVIM_APPNAME` environment variable. This can be useful to test new configuration without affecting the “main” config:

- Create a new directory for the new config: `mkdir -p ~/.config/nvim-new`
- Run `nvim` with the new config: `NVIM_APPNAME=nvim-new nvim`
- Replace actual config with the new one when you feel its ready.

It's hard coded to `.config` directory so the value is just the name of the directory.

## Other

Other things I have encountered that are easy to forget or miss:

- ⚠️ WARNING libuv-watchdirs has known performance issues. Consider installing inotify-tools.
