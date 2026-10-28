# `coffee_`

An iOS app to track your coffee.

This app is being built live on [YouTube](https://youtube.com/@heyjaycodes).

## Project setup

### Prerequisites

- [Node.js](https://nodejs.org) is needed for git hooks
- Xcode 15 (@heyjaywilson suggests using the [Xcodes app](https://github.com/XcodesOrg/XcodesApp) to manage Xcode versions)
- swift-format comes with Xcode and runs through `xcrun swift-format`, so there's nothing extra to install

### Steps

1. Clone the repo
2. Navigate into the repo via the command line
3. Run `npx husky install` to install git hooks

## Committing

Commit messages and PR titles become the in-app release notes. Read [docs/COMMITTING.md](docs/COMMITTING.md) before opening a PR.

# Architecture

This app is following a micro app architecture and uses Swift Package Manager to handle all the packages and modules in the app.