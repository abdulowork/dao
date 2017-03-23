//
//  CascadeRealmObject.swift
//  Pods
//
//  Created by Timofey on 3/23/17.
//
//

import Foundation
import RealmSwift

public protocol CascadeRealmObject {
  var cascadeProperties: [Object] { get }
}

extension Object: CascadeRealmObject {
  open var cascadeProperties: [Object] {
    return []
  }
}
