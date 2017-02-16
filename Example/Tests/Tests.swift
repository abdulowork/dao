import UIKit
import XCTest
import DAO
import RealmSwift

class Tests: XCTestCase {
  
  func testItemRealmDAO() {
    let dao = ItemRealmDAO()
    print(dao.operationalRealm.configuration.fileURL)
    let item = Item(name: "Test")
    
    try! dao.persist(entity: item)
    //    XCTAssert(dao.getAll())
    XCTAssert(item == dao.get(forPrimaryKey: "Test"))
    try! dao.remove(entity: item)
    XCTAssert(dao.getAll().isEmpty)
    XCTAssert(dao.operationalRealm.objects(SomeRealmObject.self).isEmpty)
    
  }
  
  func testPersistMultiplerItems() {
    let dao = ItemRealmDAO()
    let items = [Item(name: "Test"), Item(name: "Test2")]
    try! dao.persist(entities: items)
    XCTAssert(items == dao.getAll())
  
  }
  
}

