//
//  DAO.swift
//  Pods
//
//  Created by Timofey on 2/11/17.
//
//

import Foundation

public protocol DAO {
  
  associatedtype EntityType: Persistable
  
  func persist(entity: EntityType) throws
  func persist(entities: [EntityType]) throws
  func getAll() -> [EntityType]
  func get(for primaryKey: EntityType.PrimaryKeyType) -> EntityType?
  func update(entity: EntityType) throws
  func update(entities: [EntityType]) throws
  func remove(entity: EntityType) throws
  func remove(entities: [EntityType]) throws
  func purge() throws
  
}
