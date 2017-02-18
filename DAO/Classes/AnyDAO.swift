//
//  AnyDAO.swift
//  Pods
//
//  Created by Timofey on 2/13/17.
//
//

import Foundation

public final class AnyDAO<Entity, Entry, PrimaryKey>: DAO {
  
  public typealias EntityType = Entity
  public typealias EntryType = Entry
  public typealias PrimaryKeyType = PrimaryKey
  
  private let _persist: (EntityType) throws -> Void
  private let _persistMultiple: ([EntityType]) throws -> Void
  private let _getAll: (Void) -> [EntityType]
  private let _get: (PrimaryKeyType) -> EntityType?
  private let _remove: (EntityType) throws -> Void
  private let _removeMultiple: ([EntityType]) throws -> Void
  private let _update: (EntityType) throws -> Void
  private let _updateMultiple: ([EntityType]) throws -> Void
  private let _getTranslator: () -> AnyTranslator<EntityType, EntryType>
  
  public init<Base: DAO where Base.EntityType == Entity, Base.EntryType == Entry, Base.PrimaryKeyType == PrimaryKey>(base: Base) {
    _persist          = base.persist
    _persistMultiple  = base.persist
    _getAll           = base.getAll
    _get              = base.get
    _update           = base.update
    _updateMultiple   = base.update
    _remove           = base.remove
    _removeMultiple   = base.remove
    _getTranslator    = base.translator
  }
  
  public func translator() -> AnyTranslator<EntityType, EntryType> {
    return _getTranslator()
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
  
  public func get(forPrimaryKey: PrimaryKeyType) -> EntityType? {
    return _get(forPrimaryKey)
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

}
