//
//  CoffeeTrackerTests.swift
//  CoffeeTrackerTests
//
//  Created by Maegan Wilson on 4/6/22.
//

import XCTest
import SwiftUI
@testable import Coffee_

class CoffeeTrackerTests: XCTestCase {

    var sut: BeanRowViewOO?

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        sut = BeanRowViewOO(bean: testRoast)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete.
        // Check the results with assertions afterwards.
    }

    func test_toggleDetails() {
        guard let sut = sut else {
            return
        }
        XCTAssertFalse(sut.showDetails)
        sut.toggleDetails()
        XCTAssert(sut.showDetails)
    }

    func test_coffeTypeIcon() {
        guard let sut = sut else {
            return
        }
        XCTAssertEqual(sut.coffeeTypeIcon, Image(systemName: SFSymbols.rectRoundedBottom))
    }

}
