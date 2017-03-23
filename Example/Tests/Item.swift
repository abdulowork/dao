//
//  Item.swift
//  DAO
//
//  Created by Timofey on 3/23/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation
import DAO

struct Item: Persistable, Equatable {
  
  typealias PrimaryKeyType = String
  
  let name: String
  
  static func ==(lhs: Item, rhs: Item) -> Bool {
    return lhs.name == rhs.name
  }
  
}
