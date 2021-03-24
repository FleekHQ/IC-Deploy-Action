![](https://storageapi.fleek.co/fleek-team-bucket/Blog%20Inline/ic-action.png)

# Deploy Action
[![Fleek](https://img.shields.io/badge/Made%20by-Fleek-blue)](https://fleek.co/)
[![Dev Slack](https://img.shields.io/badge/Dev%20Slack-Channel-blue)](https://slack.fleek.co/)
[![License](https://img.shields.io/badge/License-MIT-green)](https://github.com/FleekHQ/space-sdk/blob/master/LICENSE)


## Introduction

Fleek's Deploy Action provides an easy way to deploy your configured Fleek site's publish directory.

## Example Usage

Create a `.github/workflows/deploy.yml` workflow file in your repository with the following configuration:

```yml
on: [push]

jobs:
  test-deploy:
    runs-on: ubuntu-latest
    name: A job to test the action-deploy action by deploying a test site
    steps:
      - uses: actions/checkout@v2
      - name: Deploy test site
        id: deploy
        uses: fleekhq/action-deploy@v1
        with:
          apiKey: ${{ secrets.FLEEK_API_KEY }}
      - name: Get the output url
        run: echo "Deploy url is ${{ steps.deploy.outputs.deployUrl }}"
```


## Configuration Options

The action can be configured with the following input arguments:

- apiKey (required) - Your Fleek scoped API key that has permission to deploy to the configured site. 

- workDir (optional) - The location of your .fleek.json config file. Defaults to repositories base directory.

- commitHash - (optional) - Optional git commit hash to deploy. Only useful for fleek sites linked to github.

## Contributing

To submit a feature, bug fix, or enhancement to Deploy Actions, follow these steps:

1. Fork this repository.
2. Make desired changes.
3. Confirm a successful Docker build with `docker build -t fleekhq/action-deploy .`.
4. [Open a Pull Request and follow the prompts](https://github.com/fleekhq/action-deploy/compare).

We value and appreciate all contributions.

## Related Resources

- [Fleek CLI](https://github.com/fleekhq/fleek-cli)
- [Fleek](https://fleek.co)

## License

Fleeks Deploy Action is licensed under a [GNU General Public License](LICENSE)
