//
//  RealmItem.swift
//  DAO
//
//  Created by Timofey on 3/23/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation
import DAO
import RealmSwift

final class RealmItem: Object, EntryType {
  
  public static func entry(from: Item) -> RealmItem {
    let realmItem = RealmItem()
    realmItem.name = from.name
    return realmItem
  }

  func toEntity() -> Item {
    return Item(name: name)
  }
  
  typealias EntityType = Item
  
  dynamic var name: String!
  
  override func isEqual(_ object: Any?) -> Bool {
    if let object = object as? RealmItem {
      return self.name == object.name
    }
    return super.isEqual(object)
  }
  
  override static func primaryKey() -> String? {
    return "name"
  }
  
}
