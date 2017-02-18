import UIKit
import XCTest
import DAO
import RealmSwift

class Tests: XCTestCase {
  
  func testItemRealmDAO() {
//    print(dao.operationalRealm.configuration.fileURL)
//    let item = Item(name: "Test")
////    let dao = item.persistanceImplementor() as! AnyDAO<Any , ItemRealmDAO, String>
//    
//    try! dao.persist(entity: item)
//    //    XCTAssert(dao.getAll())
//    XCTAssert(item == dao.get(forPrimaryKey: "Test"))
//    try! dao.remove(entity: item)
//    XCTAssert(dao.getAll().isEmpty)
//    XCTAssert(dao.operationalRealm.objects(SomeRealmObject.self).isEmpty)
    
  }
  
  func testPersistMultiplerItems() {
    let dao = ItemRealmDAO()
    let items = [Item(name: "Test"), Item(name: "Test2")]
    try! dao.persist(entities: items)
    XCTAssert(items == dao.getAll())
  
  }
  
  func testItemArrayDAO() {
    let dao = ItemArrayDAO()
    let item = Item(name: "Test")
    try! dao.persist(entity: item)
    XCTAssert(dao.getAll().contains(item))
    XCTAssert(dao.getAll().contains(Item(name: "Test")))
    try! dao.remove(entity: item)
    XCTAssert(dao.getAll().isEmpty)
  }
  
}

