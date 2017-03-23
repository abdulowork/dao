//
//  EntryType.swift
//  Pods
//
//  Created by Timofey on 3/23/17.
//
//

import Foundation

public protocol EntryType: class {
  
  associatedtype EntityType: Persistable
  
  //HACK: Initializing from Realm's Object is not possible: see playground
  static func entry(from: EntityType) -> Self
  
  func toEntity() -> EntityType

}
