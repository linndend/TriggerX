#!/bin/bash

clear

center_text() {
  local text="$1"
  local width=$(tput cols)
  local padding=$(( (width - ${#text}) / 2 ))
  printf "%*s%s\n" $padding "" "$text"
}

line=$(printf '=%.0s' $(seq 1 $(tput cols)))

echo "$line"
center_text "Setup TriggerX Node"
echo "$line"

clear

echo "============================================="
echo        "INSTALL DEPENDENCIES & ENV"
echo "============================================="

sudo apt update && sudo apt upgrade -y
sleep 3
sudo apt install git nodejs npm curl
sleep
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash 
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")" && [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" 
nvm i --lts
sleep 3

echo "============================================="
echo        "Setup NODE"
echo "============================================="



git clone https://github.com/trigg3rX/triggerx-keeper-setup.git
sleep 3
cd triggerx-keeper-setup
sleep 2
npm i -g @othentic/othentic-cli
sleep 3
source ~/.bashrc
sleep 2
curl -4 ifconfig.me
echo "Save ip..."
sleep 5
othentic-cli node get-id --node-type attester
echo "Save peer_ID..."
sleep 8
cp .env.example .env
nano .env
sleep 5

othenthic-cli operator register-eigenlayer
sleep 3
othenthic-cli operator register
sleep 2
chmod +x ./triggerx.sh
./triggerx.sh start 
sleep 3
./triggerx.sh start-mon

echo "✅ Setup complete!"
echo "Check Status"
./triggerx.sh status
