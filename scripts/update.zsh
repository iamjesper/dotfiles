#!/bin/zsh

source "$DOTDIR/zsh/env.zsh"
PATH="/usr/local/bin/:$PATH"
SUDO_ASKPASS="$HOME/.askpass" \

eval "$(fnm env)"

trap 'ret=$?; test $ret -ne 0 && terminal-notifier -group "Upgrade script" -title "Upgrade script" -message "Encountered an error! Check the logs for details."; exit $ret' EXIT
set -e

terminal-notifier -title "Upgrade script" -message "Running..." -group "Upgrade script"

printf "Running brew update...\n"            | ts
brew update
printf "\n\n\n"

printf "Running brew upgrade...\n"           | ts
brew upgrade --fetch-HEAD
printf "\n\n\n"

printf "Running brew cask upgrade...\n"      | ts
brew upgrade --cask --force
printf "\n\n\n"

printf "Updating Node installation...\n"     | ts
fnm install --lts && fnm use lts-latest && fnm default lts-latest
printf "\n\n\n"

printf "Installing global NPM packages...\n" | ts
npm install -g $(cat "$DOTDIR/npm-global-packages" | tr '\n' ' ')
printf "\n\n\n"

printf "Updating TLDR local data...\n"       | ts
tldr --update
printf "\n\n\n"

printf "Updating antibody plugins...\n"      | ts
antibody bundle < "$DOTDIR/zsh/zsh_plugins" > ~/.zsh_plugins
printf "\n\n\n"

printf "Updating Python packages...\n"       | ts
python3 -m pip install --user --upgrade $(cat "$DOTDIR/pip-packages" | tr '\n' ' ')
printf "\n\n\n"

terminal-notifier -title "Upgrade script" -message "Finished!" -group "Upgrade script"
printf     "\n\n\n"
