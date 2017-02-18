//
//  ItemArrayDAO.swift
//  DAO
//
//  Created by Timofey on 2/18/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation
import DAO

final class ItemArrayDAO: ArrayDAO {
  
  typealias EntityType = Item
  typealias EntryType = Item
  typealias PrimaryKeyType = String
  
  func translator() -> AnyTranslator<Item, Item> {
    return AnyTranslator(base: ItemArrayTranslator())
  }
  
  var storageArray: [Item] = []
  
}

struct ItemArrayTranslator: Translator {
  
  typealias EntryType = Item
  typealias EntityType = Item
  
  func map(entry: Item) -> Item {
    return entry
  }
  
  func map(entity: Item) -> Item {
    return entity
  }
  
  
}
