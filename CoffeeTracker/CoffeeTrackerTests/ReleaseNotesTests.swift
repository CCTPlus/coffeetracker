//
//  ReleaseNotesTests.swift
//  CoffeeTrackerTests
//
//  Created by Jay Wilson on 10/28/26.
//

import XCTest

@testable import Coffee_

class ReleaseNotesTests: XCTestCase {

  let changelog = """
    # Changelog

    ## [1.3.0](https://github.com/CCTPlus/coffeetracker/compare/v1.2.0...v1.3.0) (2026-11-10)


    ### Features

    * share a coffee as a picture ([abc1234](https://github.com/CCTPlus/coffeetracker/commit/abc1234))

    ## [1.2.0](https://github.com/CCTPlus/coffeetracker/compare/v1.1.0...v1.2.0) (2026-10-28)


    ### ⚠ BREAKING CHANGES

    * drop support for old data

    ### Bug Fixes

    * close new bean form on successful addition ([#96](https://github.com/CCTPlus/coffeetracker/issues/96)) ([2ea4dff](https://github.com/CCTPlus/coffeetracker/commit/2ea4dff))

    ### Features

    * redesign the main view ([9a19c98](https://github.com/CCTPlus/coffeetracker/commit/9a19c98))
    * **roasters:** store new roaster and bean association ([a381825](https://github.com/CCTPlus/coffeetracker/commit/a381825)), closes [#87](https://github.com/CCTPlus/coffeetracker/issues/87)

    ### Performance Improvements

    * load beans faster ([1234567](https://github.com/CCTPlus/coffeetracker/commit/1234567))

    ## 1.1.0 (2022-06-06)

    ### Features

    * old feature
    """

  func test_parse_readsOnlyRequestedVersion() throws {
    let notes = try XCTUnwrap(ReleaseNotes.parse(changelog: changelog, version: "1.3.0"))
    XCTAssertEqual(notes.version, "1.3.0")
    XCTAssertEqual(notes.sections, [.init(kind: .features, items: ["Share a coffee as a picture"])])
  }

  func test_parse_cleansItemsAndOrdersSections() throws {
    let notes = try XCTUnwrap(ReleaseNotes.parse(changelog: changelog, version: "1.2.0"))
    XCTAssertEqual(
      notes.sections,
      [
        .init(
          kind: .features,
          items: ["Redesign the main view", "Store new roaster and bean association"]
        ),
        .init(kind: .bugFixes, items: ["Close new bean form on successful addition"]),
        .init(kind: .performance, items: ["Load beans faster"]),
      ]
    )
  }

  func test_parse_handlesHeaderWithoutLink() throws {
    let notes = try XCTUnwrap(ReleaseNotes.parse(changelog: changelog, version: "1.1.0"))
    XCTAssertEqual(notes.sections, [.init(kind: .features, items: ["Old feature"])])
  }

  func test_parse_returnsNilForMissingVersion() {
    XCTAssertNil(ReleaseNotes.parse(changelog: changelog, version: "9.9.9"))
    XCTAssertNil(ReleaseNotes.parse(changelog: "", version: "1.2.0"))
  }

  func test_parse_doesNotMatchVersionPrefix() {
    XCTAssertNil(ReleaseNotes.parse(changelog: changelog, version: "1.2"))
  }
}
