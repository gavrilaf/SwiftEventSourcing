import XCTest
import EventSourcing

class EventSourcingTests: XCTestCase {
    
    let storage = InMemoryEventStorage()
    
    func testSimpleAggregator() {
        let manager = Manager(eventStorage: storage)
        
        let id = manager.createAggregator()
        
        manager.handle(command: DepositCommand(aggregator: id, amount: 10))
        manager.handle(command: WithdrawalCommand(aggregator: id, amount: 2))
        manager.handle(command: WithdrawalCommand(aggregator: id, amount: 2))
        manager.handle(command: WithdrawalCommand(aggregator: id, amount: 2))
        
        XCTAssertEqual(manager.getAggregator(id: id)?.balance, 4)
        
    }


    static var allTests = [
        ("testSimpleAggregator", testSimpleAggregator),
    ]
}
