//
//  File.swift
//
//
//  Created by Jay on 4/5/24.
//

import Foundation

enum MockID {
  public static let bean = UUID()
  public static let roaster = UUID()
}

extension Bean {
  public static let mock = Bean(
    id: MockID.bean,
    name: "Holler Mountain",
    website: "https://www.stumptowncoffee.com/products/holler-mountain",
    roastStyle: .medium,
    roaster: .mock
  )
}

extension Roaster {
  public static let mock = Roaster(
    id: MockID.roaster,
    name: "Stumptown Coffee",
    website: "https://stumptown.com",
    beanIDs: [MockID.bean.uuidString]
  )
}
