# Committing

Commit messages and PR titles are not just for us. They become the release notes.

PRs are squash-merged, so the **PR title becomes the commit on `main`**. Release-please turns those commits into `CHANGELOG.md`, and the app shows that changelog on the "What's new" screen. Whatever you write in a `feat:` or `fix:` title is what users read.

## The rule

**Every commit message and PR title must be user facing.**

Write it for someone who uses the app, not someone who reads the code. Describe what changed for them, not how it was built.

## Format

We use [Conventional Commits](https://www.conventionalcommits.org), checked by commitlint and the PR title workflow.

```
<type>: <what changed for the user>
```

- Lowercase subject, no period at the end, imperative mood ("add", not "added").
- The app capitalizes the first letter when it shows the note.
- Don't use a scope on `feat` or `fix`. Users don't know what `(roasters)` means and the app strips it anyway.

## Which type to use

| Type | Shows in the app as | Use it for |
| --- | --- | --- |
| `feat` | Features | Something new a user can do or see |
| `fix` | Bug Fixes | Something that was broken for users and now works |
| `perf` | Improvements | Something users will notice is faster or smoother |
| `chore`, `refactor`, `build`, `ci`, `test`, `docs`, `style` | Hidden | Internal work users won't notice |

If users won't notice the change, it isn't `feat` or `fix`. Internal work still uses the hidden types, but keep those titles readable too.

## Examples

| ✅ Good | ❌ Bad |
| --- | --- |
| `feat: share a coffee as a picture` | `feat: add ShareSheet wrapper` |
| `fix: close the new bean form after saving` | `fix: set isPresented to false in onSubmit` |
| `feat: redesign the coffee list` | `feat: update views` |
| `perf: open the app faster` | `perf: cache NSPersistentContainer` |
| `chore: update RevenueCat to 5.99.0` | `feat: update RevenueCat to 5.99.0` |

## Versions

Never change the app version by hand. Release-please owns it:

- It reads the commits since the last release and opens a release PR with the new version and changelog.
- That PR also bumps `MARKETING_VERSION` in `CoffeeTracker.xcodeproj/project.xcproj` (via the `// x-release-please-version` marker) and `package.json`.
- Merging the release PR tags the release. Builds from that commit show the matching "What's new" notes.

The "Check App Version" workflow fails a PR if `MARKETING_VERSION` doesn't match `.release-please-manifest.json`, or if Xcode drops the marker comment when it rewrites the project file.
