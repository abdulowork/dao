import UIKit
import XCTest
import DAO
import RealmSwift

class Tests: XCTestCase {
  
  func testItemRealmDAO() {
    let dao = ItemRealmDAO()
    let item = Item(name: "Test")
    
    try! dao.persist(entity: item)
    //    XCTAssert(dao.getAll())
    XCTAssert(item == dao.get(forPrimaryKey: "Test"))
    try! dao.remove(entity: item)
    XCTAssert(dao.getAll().isEmpty)
    
  }
  
}

