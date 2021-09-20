![](https://storageapi.fleek.co/fleek-team-bucket/ic-action.png)

# IC Deploy Action
[![Fleek](https://img.shields.io/badge/Made%20by-Fleek-blue)](https://fleek.co/)
[![Dev Slack](https://img.shields.io/badge/Dev%20Slack-Channel-blue)](https://slack.fleek.co/)
[![License](https://img.shields.io/badge/License-MIT-green)](https://github.com/FleekHQ/space-sdk/blob/master/LICENSE)


## Introduction

Fleek's IC deploy action wraps commands from the [dfx](https://github.com/dfinity/docs) command line tool, which deploys canister to the [Internet Computer](https://dfinity.org/).


The Github Action will trigger a new deployment to the Internet Computer when commits are pushed.

## Example Usage

Create a `.github/workflows/deploy.yml` workflow file in your repository with the following configuration:

```yml
on: [push]

jobs:
  test-deploy:
    runs-on: ubuntu-latest
    name: A job to deploy canisters to the IC
    steps:
      - uses: actions/checkout@v2
      - name: Install dependencies
        run: npm install
      - name: Deploy canisters
        id: deploy
        uses: fleekhq/ic-deploy-action@master
        with:
          identity: ${{ secrets.DFX_IDENTITY }}
          wallets: ${{ secrets.DFX_WALLETS }}
      - name: Show success message
        run: echo success!
```

## Initial Setup
Before including the Github Action to your CI/CD pipeline, you need a project configured and deployed to the IC.

If it's not already done, create a new project with the `dfx` CLI.

```
dfx new hello-world
```

Then, you can make an initial deployment to the IC after having installed dependencies with `npm install` if necessary.

```
dfx deploy --network=ic
```

The canisters are now deployed. At this point, a `canister_ids.json` file will have been created in your repository. It's important to push this file to github, because it identifies your Canister on the IC.

Furthermore, these canisters have been deployed with a particular identity, which you by default is called `default`. We will have to export the private key associated with that identity through a Github secret.

## Github Secrets
As seen in the code snippets in the previous section, the Github Action necessitates the addition of two secrets in order to make additional deployments through the same identity.

### DFX_IDENTITY
We have to export the content of your `default` identity and modify it so that it fits in a single line.

First, locate your identity. For the `default` identity on Linux, it can be found in the following location `~/.config/dfx/identity/default/identity.pem`.

Run the command below and copy the output to the `DFX_IDENTITY` Github Secret. The command below can be modified if the path to the `identity.pem` file differs.

```
awk 'NF {sub(/\r/, ""); printf "%s\\r\\n",$0;}' ~/.config/dfx/identity/default/identity.pem
```

### DFX_WALLETS
Copy the contents of the `wallets.json` file that in the same directory as the `identity.pem` file and paste it to the `DFX_WALLETS` Github secret. The content of the file can be retrieved by the code below.

```
cat ~/.config/dfx/identity/default/wallets.json
```

Note that this file will not be present if you have not initially deployed the canisters.

## Optional inputs
### Network
By default, the action will deploy with the command `dfx deploy --network=ic`, but the value of `ic` can be overriden through the `network` input.

```yml
on: [push]

jobs:
  test-deploy:
    runs-on: ubuntu-latest
    name: A job to deploy canisters to the IC
    steps:
      - uses: actions/checkout@v2
      - name: Install dependencies
        run: npm install
      - name: Deploy canisters
        id: deploy
        uses: fleekhq/ic-deploy-action@master
        with:
          identity: ${{ secrets.DFX_IDENTITY }}
          wallets: ${{ secrets.DFX_WALLETS }}
          network: alpha
      - name: Show success message
        run: echo success!
```

### dfx_params
The parameters of the dfx call can be customized with the `dfx_params` input. This input will simply append the content of the input to the dfx command.
For example, in order to run, `dfx --no-wallet` instead of the default `dfx`, input `--no-wallet` to this input.

```yml
on: [push]

jobs:
  test-deploy:
    runs-on: ubuntu-latest
    name: A job to deploy canisters to the IC
    steps:
      - uses: actions/checkout@v2
      - name: Install dependencies
        run: npm install
      - name: Deploy canisters
        id: deploy
        uses: fleekhq/ic-deploy-action@master
        with:
          identity: ${{ secrets.DFX_IDENTITY }}
          wallets: ${{ secrets.DFX_WALLETS }}
          dfx_params: --no-wallet
      - name: Show success message
        run: echo success!
```

## Contributing

There are a lot of variations of Canister deployments possible, such as not using the default identity and wallet, different working directories, deployments that flushes the memory in the canisters and some that don't, etc...

Any contributions that offer more flexibility and options are very valuable!

To submit a feature, bug fix, or enhancement to Deploy Actions, follow these steps:

1. Fork this repository.
2. Make desired changes.
3. Confirm a successful Docker build with `docker build -t fleekhq/IC-Deploy-Action .`.
4. [Open a Pull Request and follow the prompts](https://github.com/fleekhq/IC-Deploy-Action/compare).

We value and appreciate all contributions.

## License

Fleeks IC Deploy Action is licensed under a [GNU General Public License](LICENSE)
