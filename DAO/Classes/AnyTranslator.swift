//
//  AnyTranslator.swift
//  Pods
//
//  Created by Timofey on 2/15/17.
//
//

import Foundation

public struct AnyTranslator<Entity, Entry>: Translator {
  
  public typealias EntityType = Entity
  public typealias EntryType = Entry
  
  private let _mapToEntity: (EntryType) -> EntityType
  private let _mapToEntry: (EntityType) -> EntryType
  
  public init<Base: Translator where Base.EntityType == Entity, Base.EntryType == Entry>(base: Base) {
    _mapToEntity  = base.map
    _mapToEntry   = base.map
  }
  
  public func map(entity: EntityType) -> EntryType {
    return _mapToEntry(entity)
  }
  
  public func map(entry: Entry) -> Entity {
    return _mapToEntity(entry)
  }
  
  
}
