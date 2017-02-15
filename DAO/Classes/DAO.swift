//
//  DAO.swift
//  Pods
//
//  Created by Timofey on 2/11/17.
//
//

import Foundation

public protocol DAO {
  
  associatedtype EntityType
  associatedtype EntryType
  associatedtype PrimaryKeyType
  
  func persist(entity: EntityType) throws
  func persist(entities: [EntityType]) throws
  func getAll() -> [EntityType]
  func get(forPrimaryKey: PrimaryKeyType) -> EntityType?
  func update(entity: EntityType) throws
  func update(entities: [EntityType]) throws
  func remove(entity: EntityType) throws
  func remove(entities: [EntityType]) throws
  
  func translator() -> AnyTranslator<EntityType, EntryType>
  
}
