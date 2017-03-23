import UIKit
import XCTest
import DAO
import RealmSwift

class RealmTests: XCTestCase {
  
  var dao: AnyDAO<Item>!
  let inmemoryIdentifier = "Realm.Test"
  
  var sampleItem: Item!
  var sampleItems: [Item]!
  
  let firstObjectKey  = "sampleName"
  let secondObjectKey = "sampleName1"
  let thirdObjectKey  = "sampleName2"
  let nonExistantKey  = "HOMELESS IS NOT IN CHARGE"
    
  override func setUp() {
    
    guard let testableRealm = try? Realm(configuration: .init(inMemoryIdentifier: inmemoryIdentifier)) else {
      XCTFail()
      fatalError()
    }
    dao = AnyDAO(base: CascadeRealmDAO<RealmItem>(operationalRealm: testableRealm))
    sampleItem = Item(name: firstObjectKey)
    sampleItems = [Item(name: firstObjectKey), Item(name: secondObjectKey), Item(name: thirdObjectKey)]
  }
  
  override func tearDown() {
    dao = nil
    sampleItem = nil
    sampleItems = nil
  }
  
  func testPersistingItem() {
    try! dao.persist(entity: sampleItem)
    XCTAssert(dao.getAll().contains(sampleItem))
  }
  
  func testPersistingMultipleItems() {
    try! dao.persist(entities: sampleItems)
    for item in sampleItems {
      XCTAssert(dao.getAll().contains(item))
    }
  }
  
  func testPersistingAnDeletingItem() {
    try! dao.persist(entity: sampleItem)
    XCTAssert(dao.getAll().contains(sampleItem))
    
    try! dao.remove(entity: sampleItem)
    XCTAssert(dao.getAll().isEmpty)
  }
  
  func testPersistingAndDeletingMultipleItems() {
    try! dao.persist(entities: sampleItems)
    for item in sampleItems {
      XCTAssert(dao.getAll().contains(item))
    }
    
    try! dao.remove(entities: sampleItems)
    XCTAssert(dao.getAll().isEmpty)
  }
  
  func testGetByKey() {
    try! dao.persist(entities: sampleItems)
    for item in sampleItems {
      XCTAssert(dao.getAll().contains(item))
    }
    
    //true
    XCTAssert(dao.get(for: firstObjectKey) == sampleItems[0])
    XCTAssert(dao.get(for: secondObjectKey) == sampleItems[1])
    XCTAssert(dao.get(for: thirdObjectKey) == sampleItems[2])
    
    //false
    XCTAssert(dao.get(for: nonExistantKey) == nil)
  }
  
  func testPurge() {
    try! dao.persist(entities: sampleItems)
    for item in sampleItems {
      XCTAssert(dao.getAll().contains(item))
    }
    
    try! dao.purge()
    XCTAssert(dao.getAll().isEmpty)
  }
  
  //TODO: Testing for cascade objects
  
}

