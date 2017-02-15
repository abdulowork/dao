//
//  ItemRealmDAO.swift
//  DAO
//
//  Created by Timofey on 2/15/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation
import DAO
import RealmSwift

class ItemRealmDAO: Object, RealmDAO {
  
  typealias PrimaryKeyType = String
  typealias EntityType = Item
  typealias EntryType = ItemRealmDAO
  
  dynamic var name: String! = ""
  
  var operationalRealm: Realm {
    return try! Realm(configuration: Realm.Configuration(inMemoryIdentifier: "TestableRealm"))
  }
  
  func translator() -> AnyTranslator<Item, ItemRealmDAO> {
    return AnyTranslator(base: ItemTranslator())
  }
  
  override func isEqual(_ object: Any?) -> Bool {
    if let item = object as? ItemRealmDAO {
      return self.name == item.name
    }
    return super.isEqual(object)
  }
  
  override static func primaryKey() -> String? {
    return "name"
  }
  
}

struct ItemTranslator: Translator {
  
  typealias EntityType = Item
  typealias EntryType = ItemRealmDAO
  
  func map(entry: ItemRealmDAO) -> Item {
    let item = Item(name: entry.name)
    return item
  }
  
  func map(entity: Item) -> ItemRealmDAO {
    let item = ItemRealmDAO()
    item.name = entity.name
    return item
  }
  
}
