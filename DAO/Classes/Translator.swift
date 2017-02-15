//
//  Translator.swift
//  Pods
//
//  Created by Timofey on 2/15/17.
//
//

import Foundation

public protocol Translator {
  
  associatedtype EntityType
  associatedtype EntryType
  
  func map(entity: EntityType) -> EntryType
  func map(entry: EntryType) -> EntityType
  
}

//TODO: NSCoding compliant default
