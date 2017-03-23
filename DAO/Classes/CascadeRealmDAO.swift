//
//  CascadeRealmDAO.swift
//  Pods
//
//  Created by Timofey on 3/22/17.
//
//

import Foundation
import RealmSwift

open class CascadeRealmDAO<Entry where Entry: Object, Entry: EntryType & CascadeRealmObject & Equatable>: DAO {
  
  public typealias EntityType = Entry.EntityType
  
  var operationalRealm: Realm
  
  public init(operationalRealm: Realm) {
    self.operationalRealm = operationalRealm
  }
  
  //MARK: Create
  
  public func persist(entities: [EntityType]) throws {
    try operationalRealm.write {
      operationalRealm.add(entities.map{ Entry.entry(from: $0) }, update: true)
    }
  }
  
  public func persist(entity: EntityType) throws {
    try operationalRealm.write {
      operationalRealm.add(Entry.entry(from: entity), update: true)
    }
  }
  
  //MARK: Read
  
  public func get(for primaryKey: EntityType.PrimaryKeyType) -> EntityType? {
    let entry = operationalRealm.object(ofType: Entry.self, forPrimaryKey: primaryKey)
    return entry?.toEntity()
  }
  
  public func getAll() -> [EntityType] {
    let entries = operationalRealm.objects(Entry.self)
    return entries.map{ $0.toEntity() }
  }
  
  //MARK: Update
  
  public func update(entities: [EntityType]) throws {
    try persist(entities: entities)
  }
  
  public func update(entity: EntityType) throws {
    try persist(entity: entity)
  }
  
  //MARK: Delete
  
  private func removeCascadeProperties(object: Object) throws {
    for property in object.cascadeProperties {
      try removeCascadeProperties(object: property)
      try operationalRealm.write {
        operationalRealm.delete(property)
      }
    }
  }
  
  public func remove(entities: [EntityType]) throws {
    let entriesCopy: [Entry] = entities.map{ Entry.entry(from: $0) }
    let existantRealmEntriesMatchingCopies = try operationalRealm.objects(Entry.self).filter{ entriesCopy.contains($0) }
    for entry in existantRealmEntriesMatchingCopies {
      try removeCascadeProperties(object: entry)
    }
    try operationalRealm.write {
      operationalRealm.delete(existantRealmEntriesMatchingCopies)
    }
  }
  
  public func remove(entity: EntityType) throws {
    let entryCopy: Entry = Entry.entry(from: entity)
    let existantRealmEntriesMatchingCopy = try operationalRealm.objects(Entry.self).filter{ $0 == entryCopy }
    for entry in existantRealmEntriesMatchingCopy {
      try removeCascadeProperties(object: entry)
    }
    
    try operationalRealm.write {
      operationalRealm.delete(existantRealmEntriesMatchingCopy)
    }
  }
  
  public func purge() throws {
    let entries = try operationalRealm.objects(Entry.self)
    for entry in entries {
      try removeCascadeProperties(object: entry)
    }
    try operationalRealm.write {
      operationalRealm.delete(entries)
    }
  }
  
}
