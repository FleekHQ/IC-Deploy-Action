#!/bin/sh -l

echo Creating deployer directory

mkdir ~/.config
mkdir ~/.config/dfx
mkdir ~/.config/dfx/identity
mkdir ~/.config/dfx/identity/default

echo Adding identity.pem and wallets file file

echo $INPUT_IDENTITY > ~/.config/dfx/identity/default/identity.pem
sed -i 's/\\r\\n/\r\n/g' ~/.config/dfx/identity/default/identity.pem
echo $INPUT_WALLETS > ~/.config/dfx/identity/default/wallets.json

which dfx

ls /usr/loca/bin

echo "Deploying to the IC"

/usr/local/bin/dfx deploy --network=$INPUT_NETWORK $INPUT_DFX_PARAMS