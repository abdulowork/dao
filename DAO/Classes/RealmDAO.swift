//
//  RealmDAO.swift
//  Pods
//
//  Created by Timofey on 2/14/17.
//
//

import Foundation
import RealmSwift

public protocol RealmDAO: DAO {
  
  var operationalRealm: Realm { get }
  
}

public extension RealmDAO where EntryType: Object, EntryType: Equatable & CascadeRealmObject {
  
  //Не решена проблема дупликации
  func persist(entity: Self.EntityType) throws {
    try operationalRealm.write {
      operationalRealm.add(translator().map(entity: entity), update: true)
    }
  }
  
  func persist(entities: [Self.EntityType]) throws {
    try operationalRealm.write {
      operationalRealm.add(entities.map{ translator().map(entity: $0) }, update: true)
    }
  }
  
  private func removeCascadeProperties<CascadeObject: CascadeRealmObject where CascadeObject: Object>(object: CascadeObject) throws {
    for property in object.cascadeProperties {
      if let property = property as? CascadeObject {
        try removeCascadeProperties(object: property)
      }
      try operationalRealm.write {
        operationalRealm.delete(property)
      }
    }
  }

  func remove(entity: Self.EntityType) throws {
    let entryCopy = translator().map(entity: entity)
    let existantRealmEntriesMatchingCopy = try operationalRealm.objects(EntryType.self).filter{ try $0 == entryCopy }
    for entry in existantRealmEntriesMatchingCopy {
      try removeCascadeProperties(object: entry)
    }
    
    try operationalRealm.write {
      operationalRealm.delete(existantRealmEntriesMatchingCopy)
    }
  }
  
  func remove(entities: [Self.EntityType]) throws {
    let entriesCopy = entities.map{ translator().map(entity: $0) }
    let existantRealmEntriesMatchingCopies = try operationalRealm.objects(EntryType.self).filter{ entriesCopy.contains($0) }
    for entry in existantRealmEntriesMatchingCopies {
      try removeCascadeProperties(object: entry)
    }
    try operationalRealm.write {
      operationalRealm.delete(existantRealmEntriesMatchingCopies)
    }
  }
  
  func purge() throws {
    let existanceRealmEntries = operationalRealm.objects(EntryType.self)
    for entry in existanceRealmEntries {
      try removeCascadeProperties(object: entry)
    }
    
    try operationalRealm.write {
      operationalRealm.delete(existanceRealmEntries)
    }
  }

  //TODO: Как обновлять без ключа?
  func update(entity: Self.EntityType) throws {
    fatalError()
  }
  
  func update(entities: [Self.EntityType]) throws {
    fatalError()
  }
  
  func getAll() -> [Self.EntityType] {
    return operationalRealm.objects(EntryType).map{ translator().map(entry: $0) }
  }
  
  func get<K>(forPrimaryKey: K) -> Self.EntityType? {
    if let entry = operationalRealm.object(ofType: EntryType.self, forPrimaryKey: forPrimaryKey) {
      return translator().map(entry: entry)
    }
    return nil
  }
  
}

public protocol CascadeRealmObject {
  var cascadeProperties: [Object] { get }
}

//public extension CascadeRealmObject {
//  var cascadeProperties: [Object] {
//    return []
//  }
//}
