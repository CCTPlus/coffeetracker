//
//  BeanFixtures.swift
//
//
//  Created by Maegan Wilson on 2/21/22.
//

import Foundation

var lightRoast = BeanModel(name: "Verona Blend",
                            style: "Light",
                            buyAgain: true,
                            roaster: "Starbucks",
                            roastedOn: Date.now,
                            boughtOn: Date.now,
                            notes: "")

var mediumRoast = BeanModel(name: "20th Anniversary Blend",
                             style: "Medium",
                             buyAgain: false,
                             roaster: "Summermoon",
                             roastedOn: Date.now,
                             boughtOn: Date.now,
                             notes: "I like it a lot")

var testRoast = BeanModel(name: "Swiftly Brewed",
                           style: "Light",
                           buyAgain: true,
                           roaster: "Apple Inc",
                           roastedOn: Date.now,
                           boughtOn: Date.now,
                           notes: "Sold in Maegan's hopes and dreams")

let allRoasts = [lightRoast, mediumRoast, testRoast]
