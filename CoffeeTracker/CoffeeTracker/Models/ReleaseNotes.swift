//
//  ReleaseNotes.swift
//  CoffeeTracker
//
//  Created by Jay Wilson on 10/28/26.
//

import Foundation

/// Release notes for one version, read from the CHANGELOG.md that release-please writes
/// and that is bundled with the app.
struct ReleaseNotes: Equatable {
  struct Section: Equatable, Identifiable {
    enum Kind: String, CaseIterable {
      case features = "Features"
      case bugFixes = "Bug Fixes"
      case performance = "Performance Improvements"

      var title: String {
        switch self {
          case .features: return "Features"
          case .bugFixes: return "Bug Fixes"
          case .performance: return "Improvements"
        }
      }
    }

    let kind: Kind
    let items: [String]

    var id: String { kind.rawValue }
  }

  let version: String
  let sections: [Section]

  /// Notes for the version the app is running, or nil when the changelog has nothing to show for it.
  static func current(bundle: Bundle = .main) -> ReleaseNotes? {
    guard
      let version = bundle.infoDictionary?["CFBundleShortVersionString"] as? String,
      let url = bundle.url(forResource: "CHANGELOG", withExtension: "md"),
      let changelog = try? String(contentsOf: url, encoding: .utf8)
    else {
      return nil
    }
    return parse(changelog: changelog, version: version)
  }

  /// Finds the `## [x.y.z]` section for `version` and keeps the user facing subsections.
  static func parse(changelog: String, version: String) -> ReleaseNotes? {
    var sections: [Section] = []
    var inVersion = false
    var currentKind: Section.Kind?
    var currentItems: [String] = []

    func closeSection() {
      if let kind = currentKind, !currentItems.isEmpty {
        sections.append(Section(kind: kind, items: currentItems))
      }
      currentKind = nil
      currentItems = []
    }

    for rawLine in changelog.components(separatedBy: .newlines) {
      let line = rawLine.trimmingCharacters(in: .whitespaces)

      if let headerVersion = versionHeader(line) {
        if inVersion {
          break
        }
        inVersion = headerVersion == version
        continue
      }

      guard inVersion else { continue }

      if line.hasPrefix("### ") {
        closeSection()
        currentKind = Section.Kind(rawValue: String(line.dropFirst(4)))
      } else if currentKind != nil, line.hasPrefix("* ") || line.hasPrefix("- ") {
        let item = cleanItem(String(line.dropFirst(2)))
        if !item.isEmpty {
          currentItems.append(item)
        }
      }
    }
    closeSection()

    guard !sections.isEmpty else { return nil }
    sections.sort { lhs, rhs in
      let order = Section.Kind.allCases
      return order.firstIndex(of: lhs.kind)! < order.firstIndex(of: rhs.kind)!
    }
    return ReleaseNotes(version: version, sections: sections)
  }

  /// Returns the version from a release header like `## [1.2.0](https://…) (2026-10-28)`.
  private static func versionHeader(_ line: String) -> String? {
    guard line.hasPrefix("## ") || line.hasPrefix("### ") else { return nil }
    let pattern = #"^#{2,3} \[?v?(\d+\.\d+\.\d+[^\]\s]*)\]?"#
    guard
      let regex = try? NSRegularExpression(pattern: pattern),
      let match = regex.firstMatch(in: line, range: NSRange(line.startIndex..., in: line)),
      let range = Range(match.range(at: 1), in: line)
    else {
      return nil
    }
    return String(line[range])
  }

  /// Strips the scope, commit and issue links release-please adds, and capitalizes the first letter.
  private static func cleanItem(_ item: String) -> String {
    var text = item
    let removals = [
      #"^\*\*[^*]+:\*\*\s*"#,  // **scope:**
      #",?\s*closes\s+.*$"#,  // , closes [#12](…)
      #"\s*\(\[[^\]]+\]\([^)]*\)\)"#,  // ([9a19c98](…)) and ([#97](…))
    ]
    for pattern in removals {
      text = text.replacingOccurrences(
        of: pattern,
        with: "",
        options: [.regularExpression, .caseInsensitive]
      )
    }
    text = text.trimmingCharacters(in: .whitespaces)
    return text.prefix(1).uppercased() + text.dropFirst()
  }
}
