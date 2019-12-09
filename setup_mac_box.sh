curl -L -o /tmp/homebrew_install  https://raw.githubusercontent.com/Homebrew/install/master/install
/usr/bin/ruby /tmp/homebrew_install  </dev/null
brew install htop fd ag
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
sed -i.bak 's/ZSH_THEME=\"robbyrussell\"/ZSH_THEME=\"bira\"/g' ~/.zshrc
zsh
