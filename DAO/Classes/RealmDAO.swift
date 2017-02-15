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

public extension RealmDAO where EntryType: Object, EntryType: Equatable {
  
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

  func remove(entity: Self.EntityType) throws {
    let entry = translator().map(entity: entity)
    
    try operationalRealm.write {
      operationalRealm.delete(operationalRealm.objects(EntryType.self).filter{ $0 == entry })
    }
  }
  
  func remove(entities: [Self.EntityType]) throws {
    let entries = entities.map{ translator().map(entity: $0) }
    
    try operationalRealm.write {
      operationalRealm.delete(operationalRealm.objects(EntryType.self).filter{ entries.contains($0) } )
    }
  }
  
  func purge() throws {
    let entries = operationalRealm.objects(EntryType.self)
    try operationalRealm.write {
      operationalRealm.delete(entries)
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
