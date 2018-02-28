import XCTest
import EventSourcing

class EventSourcingTests: XCTestCase {
    
    var storage: InMemoryEventStorage!
    var manager: AccountManager!
    
    override func setUp() {
        storage = InMemoryEventStorage()
        manager = AccountManager(eventStorage: storage)
    }
    
    func testCreateAccount() {
        let account = manager.openAccount()
        XCTAssertEqual(account.balance, 0)
        XCTAssertEqual(account.status, .created)
        
        let account2 = manager.getAccount(id: account.id)
        XCTAssertNotNil(account2)
        XCTAssertEqual(account2!.id, account.id)
    }

    func testActivate() {
        let account = manager.openAccount()
        _ = manager.handle(command: .activate, forAccount: account.id)
        
        XCTAssertEqual(account.status, .activated)
    }

    static var allTests = [
        ("testCreateAccount", testCreateAccount),
    ]
}
