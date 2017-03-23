//
//  AnyDAO.swift
//  Pods
//
//  Created by Timofey on 2/13/17.
//
//

import Foundation

public final class AnyDAO<Entity: Persistable>: DAO {
  
  public typealias EntityType = Entity
  
  private let _persist: (EntityType) throws -> Void
  private let _persistMultiple: ([EntityType]) throws -> Void
  private let _getAll: (Void) -> [EntityType]
  private let _get: (EntityType.PrimaryKeyType) -> EntityType?
  private let _remove: (EntityType) throws -> Void
  private let _removeMultiple: ([EntityType]) throws -> Void
  private let _update: (EntityType) throws -> Void
  private let _updateMultiple: ([EntityType]) throws -> Void
  private let _purge: () throws -> Void
  
  public init<Base: DAO where Base.EntityType == Entity>(base: Base) {
    _persist          = base.persist
    _persistMultiple  = base.persist
    _getAll           = base.getAll
    _get              = base.get
    _update           = base.update
    _updateMultiple   = base.update
    _remove           = base.remove
    _removeMultiple   = base.remove
    _purge            = base.purge
  }
  
  public func persist(entity: EntityType) throws {
    try _persist(entity)
  }
  
  public func persist(entities: [EntityType]) throws {
    try _persistMultiple(entities)
  }
  
  public func getAll() -> [EntityType] {
    return _getAll()
  }
  
  public func get(for primaryKey: EntityType.PrimaryKeyType) -> EntityType? {
    return _get(primaryKey)
  }
  
  public func update(entity: EntityType) throws {
    try _update(entity)
  }
  
  public func update(entities: [EntityType]) throws {
    try _updateMultiple(entities)
  }
  
  public func remove(entity: EntityType) throws {
    try _remove(entity)
  }
  
  public func remove(entities: [EntityType]) throws {
    try _removeMultiple(entities)
  }
  
  public func purge() throws {
    try _purge()
  }

}
