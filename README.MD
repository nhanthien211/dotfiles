# General setup

## Homebrew

`/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
`
More info here: https://brew.sh/

## Terminal
Please choose one of the following setup

### iTerm2
1. Installation: `brew install --cask iterm2`
2. Configuration: use the iterm-profile.json for restoring.
3. Send key guide to fix some key mapping via terminal setting: https://stackoverflow.com/questions/16359878/how-to-map-shift-enter 

### WezTerm
1. Installation: `brew install --cask wezterm` 
2. Create .config folder if not existing under $HOME.
3. Create symbolic link from repo to .config: `ln -s ~/Documents/dotfiles/wezterm ~/.config/`

### OhMyZsh
`sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"`

### Powerline10k
1. `git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k`
2. `nano ~/.zshrc`
3. Set `ZSH_THEME="powerlevel10k/powerlevel10k"`
4. `p10k configure`
5. Choose `Yes` when prompt to install Meslo Nerd Font

More info here: https://github.com/romkatv/powerlevel10k

### zsh-syntax-highlighting 
1. `git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting`
2. `nano ~/.zshrc`
3. `plugins=( [plugins...] zsh-syntax-highlighting)`

### zsh-autosuggestions
1. `git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions`
2. `nano ~/.zshrc`
3. `plugins=( [plugins...] zsh-autosuggestions)`
4. `ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=245'`
Note: see `https://coderwall.com/p/pb1uzq/z-shell-colors` for more background color

### TheFuck
1. https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/thefuck/README.md

### Miscellaneous
- Install `fd`:
`brew install fd`
- Install `ripgrep`:
`brew install ripgrep`
- Change syntax suggest color: 
  - `nvim ~/.zshrc`
  - `ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=248'`
  - More color number: https://coderwall.com/p/pb1uzq/z-shell-colors
- Display only last folder in path:
  - `nvim ~/.p10k.zsh`
  - `POWERLEVEL9K_SHORTEN_STRATEGY=truncate_to_last`
- Remove limit for branch name:
  - `nvim ~/.p10k.zsh`
  -`(( $#branch > 32 )) && branch[13,-13]="…"  # <-- this line`
- Remove Ruby version from prompt:
  - `nvim ~/.p10k.zsh`
  - Comment out ruby
- Send key guide to fix some key mapping via terminal setting: https://stackoverflow.com/questions/16359878/how-to-map-shift-enter 
- Common alias:
    ```
    alias y="yarn"
    alias lg="lazygit"
    alias tx="tmuxinator"
    alias cl="clear"
    ```

## Neovim
1. Installation: `brew install neovim`
2. Create .config folder if not existing under $HOME.
3. Create symbolic link from repo to .config: `ln -s ~/Documents/dotfiles/nvim ~/.config/`

## Tmux
1. Installation `brew install tmux`
2. Create .config folder if not existing under $HOME.
3. Create tmux folder under ~/.config if not existing
4. Create symbolic link from repo to .config: `ln -s ~/Documents/dotfiles/tmux/tmux.conf ~/.config/tmux/`

### Tmuxinator
1. Installation: `brew install tmuxinator`
2. Run `tmuxinator new PROJECT_NAME`, which creates a file under `~/.config/tmuxinator/PROJECT_NAME.yml`

## NVM / Node / Yarn

Please follow this guideline to install node / rpm: https://nodejs.org/en/download/package-manager

`npm install --global yarn`

## RVM / Ruby / Bundler / Cocoapods

1. `brew install gnupg`
2. `echo "standard-resolver" >  ~/.gnupg/dirmngr.conf`
3. `sudo pkill dirmngr`
4. `gpg --keyserver keyserver.ubuntu.com --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB`
5. `\curl -sSL https://get.rvm.io | bash -s stable`
6. `source ~/.rvm/scripts/rvm`
7. `rvm get master`
8. `rvm install ruby-3.3.6`
9. `rvm use 3.3.6 --default`
10. `ruby -v`
11. `gem install bundler`
12. `sudo gem install cocoapods`

Also keep in mind:
- Step 4: check https://rvm.io/ for latest GPG server and key
- Step 8: check https://www.ruby-lang.org/en/downloads/ for latest Ruby version

## MacOS
- Show hidden files Finder
`defaults write com.apple.finder AppleShowAllFiles true`

- Disable C-Space shortcut
`https://apple.stackexchange.com/questions/423971/disable-controlspace-keyboard-shortcut`
