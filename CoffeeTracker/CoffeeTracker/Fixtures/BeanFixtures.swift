//
//  BeanFixtures.swift
//
//
//  Created by Maegan Wilson on 2/21/22.
//

import Foundation
import UIKit

var lightRoast = BeanModel(name: "Verona Blend",
                           style: "Light",
                           buyAgain: true,
                           roaster: "Starbucks",
                           roastedOn: Date.now,
                           boughtOn: Date.now,
                           notes: "",
                           beanType: "beans",
                           image: UIImage(systemName: SFSymbols.photo)!)

var mediumRoast = BeanModel(name: "20th Anniversary Blend",
                            style: "Medium",
                            buyAgain: false,
                            roaster: "Summermoon",
                            roastedOn: Date.now,
                            boughtOn: Date.now,
                            notes: "I like it a lot",
                            beanType: "grounds",
                            image: UIImage(systemName: SFSymbols.photo)!)

var testRoast = BeanModel(name: "Swiftly Brewed",
                          style: "Light",
                          buyAgain: true,
                          roaster: "Apple Inc",
                          roastedOn: Date.now,
                          boughtOn: Date.now,
                          notes: "Sold in Maegan's hopes and dreams. Single origin \n- Costa Rica",
                          beanType: "pods",
                          image: UIImage(systemName: SFSymbols.photo)!)

let allRoasts = [lightRoast, mediumRoast, testRoast]
