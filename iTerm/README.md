# iTermSetup

## Homebrew
`/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`

More info here: https://brew.sh/

## iTerm2

`brew install --cask iterm2`

Or download and install from here: https://iterm2.com/index.html

## OhMyZsh

`sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"`

## Powerline10k

1. `git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k`
2. `nano ~/.zshrc`
3. Set `ZSH_THEME="powerlevel10k/powerlevel10k"`
4. `p10k configure`
5. Choose `Yes` when prompt to install Meslo Nerd Font

More info here: https://github.com/romkatv/powerlevel10k

## zsh-syntax-highlighting 
1. `git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting`
2. `nano ~/.zshrc`
3. `plugins=( [plugins...] zsh-syntax-highlighting)`

## zsh-autosuggestions
1. `git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions`
2. `nano ~/.zshrc`
3. `plugins=( [plugins...] zsh-autosuggestions)`
4. `ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=245'`
Note: see https://coderwall.com/p/pb1uzq/z-shell-colors for more background color

## TheFuck
1. https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/thefuck/README.md

## Miscellaneous

- Display only last folder in path:
  - `nvim ~/.p10k.zsh`
  - `POWERLEVEL9K_SHORTEN_STRATEGY=truncate_to_last`
- Change syntax suggest color: 
  - `nvim ~/.zshrc`
  - `ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=248'`
  - More color number: https://coderwall.com/p/pb1uzq/z-shell-colors
- Remove limit for branch name:
  - `nvim ~/.p10k.zsh`
  -`(( $#branch > 32 )) && branch[13,-13]="…"  # <-- this line`
- Send key guide to fix some key mapping via terminal setting: https://stackoverflow.com/questions/16359878/how-to-map-shift-enter 
