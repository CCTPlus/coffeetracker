import Foundation
import Danger

let danger = Danger()
let github = danger.github!
let allSourceFiles = danger.git.modifiedFiles + danger.git.createdFiles

let changelogChanged = allSourceFiles.contains("CHANGELOG.md")
let sourceChanges = allSourceFiles.first(where: { $0.hasPrefix("Sources") })

if danger.github.pullRequest.title.contains("WIP") {
    warn("PR is classed as Work in Progress")
}

if !changelogChanged && sourceChanges != nil && !github.pullRequest.body!.contains("#trivial") {
  warn("No CHANGELOG entry added.")
}

// Check pr has description
if github.pullRequest.body!.count < 10 {
    fail("Include a description of PR changes")
}
