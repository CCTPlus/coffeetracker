//
//  BeanTests.swift
//
//
//  Created by Jay on 1/19/24.
//

import XCTest

@testable import Models

final class BeanTests: XCTestCase {
  func test_URLisNotNil_withHttps() {
    let testBean = Bean(name: "Test", website: "https://heyjaywilson.com", roastStyle: .medium)

    let expectedURL = URL(string: "https://heyjaywilson.com")

    XCTAssertEqual(expectedURL, testBean.url)
  }

  func test_URLisNotNil_withHttp() {
    let testBean = Bean(name: "Test", website: "http://heyjaywilson.com", roastStyle: .medium)

    let expectedURL = URL(string: "http://heyjaywilson.com")

    XCTAssertEqual(expectedURL, testBean.url)
  }

  func test_URLisNotNil_NoScheme() {
    let testBean = Bean(name: "Test", website: "heyjaywilson.com", roastStyle: .medium)
    let expectedURL = URL(string: "http:heyjaywilson.com")

    XCTAssertEqual(expectedURL, testBean.url)
  }

  func test_URLisNil() {
    let testBean = Bean(name: "Test", website: "123", roastStyle: .medium)
    XCTAssertNil(testBean.url)
  }

}
