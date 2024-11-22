# General setup

## Homebrew

`/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
`

More info here: https://brew.sh/

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

- Install `fd`:
`brew install fd`

- Install `ripgrep`:
`brew install ripgrep`
