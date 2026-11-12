<h1 align="center">
  Pablo's .dotfiles
</h1>

<p align="center">
  macOS setup on Apple silicon, built on <a href="https://github.com/CodelyTV/dotly">🌚 dotly</a> with zsh and <a href="https://zimfw.sh">Zim</a>.
</p>

## Install

```bash
git clone --recurse-submodules https://github.com/Pablorg99/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
DOTFILES_PATH="$HOME/.dotfiles" DOTLY_PATH="$DOTFILES_PATH/modules/dotly" "$DOTLY_PATH/bin/dot" self install
```

Restart the terminal, then install the apps with `dot package import`.

`dot self install` links everything declared in `symlinks/` and runs
`restoration_scripts/`, which apply the macOS preferences.

## Day to day

| Task                                   | Command                                                        |
| -------------------------------------- | -------------------------------------------------------------- |
| Re-link files after adding one         | `dot symlinks apply`                                           |
| Check the Brewfile against the machine | `brew bundle check --file=os/mac/brew/Brewfile`                |
| Re-apply macOS preferences             | `restoration_scripts/02-macos-defaults.sh`                     |
| Save system keyboard shortcuts         | `defaults export com.apple.symbolichotkeys os/mac/settings/com.apple.symbolichotkeys.plist` |
| Change a browser setting               | `ardia config set <key> <value>` (writes `os/mac/ardia/config.json`) |
| Update dotly                           | `dot self update`                                              |

The Brewfile is curated by hand: apps installed only to try them out stay off it.

## Structure

```
bin/                  personal scripts on the PATH
editors/code/         VS Code settings, keybindings and extensions
git/                  global gitignore
langs/                per-language shell setup (fnm for Node)
os/mac/               Brewfile, Ardia, LinearMouse, Raycast scripts, exported plists
restoration_scripts/  macOS preferences as `defaults write` commands
scripts/              dotly scripts, run as `dot <context> <script>`
shell/                aliases, exports, functions, bash and zsh config
symlinks/             what gets linked into $HOME
```

## Manual steps after restoring

* **Fonts**: the terminal and VS Code expect Dank Mono Nerd Font, a paid font
  that is not in Homebrew. Copy the `.otf` files to `~/Library/Fonts`. They live
  in `shell/private/fonts/`, which is git-ignored.
* **Ardia**: the browser has no Homebrew cask. Install it by hand, set it as the
  default browser in System Settings and install its CLI from
  Settings › Advanced.
* **Raycast**: add `os/mac/raycast` as a script directory. Extensions, aliases
  and hotkeys come from a `.rayconfig` export (Settings › Advanced › Import).
* **Not scripted**: keyboard input sources, Dock apps and apps without a cask
  (DaVinci Resolve).

## License

[MIT](LICENSE)
