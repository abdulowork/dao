//
//  ArrayDAO.swift
//  Pods
//
//  Created by Timofey on 2/18/17.
//
//

import Foundation

public protocol ArrayDAO: class, DAO {
  
  var storageArray: [EntryType] { get set }
  
}

public extension ArrayDAO where EntryType: Equatable {
  
  func persist(entity: Self.EntityType) throws {
    storageArray.append(translator().map(entity: entity))
  }
  
  func persist(entities: [Self.EntityType]) throws {
    storageArray.append(contentsOf: entities.map{ translator().map(entity: $0) })
  }
  
  func remove(entity: Self.EntityType) throws {
    let entry = translator().map(entity: entity)
    try storageArray.removeElementIdenticalTo(entry)
  }
  
  func remove(entities: [Self.EntityType]) throws {
    let entries = entities.map{ translator().map(entity: $0) }
    for entry in entries { try storageArray.removeElementIdenticalTo(entry) }
  }
  
  func getAll() -> [Self.EntityType] {
    return storageArray.map{ translator().map(entry: $0) }
  }
  
  func get(forPrimaryKey: Self.PrimaryKeyType) -> Self.EntityType? {
    fatalError("Primary key not supported")
  }
  
  func update(entity: Self.EntityType) throws {
    try persist(entity: entity)
  }
  
  func update(entities: [Self.EntityType]) throws {
    try persist(entities: entities)
  }
  
  func purge() throws {
    storageArray.removeAll()
  }

}

fileprivate extension Array where Element: Equatable {
  
  mutating func removeElementIdenticalTo(_ e: Element) throws {
    guard let elementIndex = self.index(of: e) else {
      throw NSError(domain: "Element not found", code: 404, userInfo: nil)
    }
    self.remove(at: elementIndex)
  }
  
}
