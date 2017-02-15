//
//  Item.swift
//  DAO
//
//  Created by Timofey on 2/15/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation
import DAO

struct Item: Equatable {
  
  var name: String
  
  static func ==(lhs: Item, rhs: Item) -> Bool {
    return lhs.name == rhs.name
  }
  
}
