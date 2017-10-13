import Foundation


public class Manager {
    
    public init(eventStorage: EventStorage) {
        self.storage = eventStorage
    }
    
    public func createAggregator() -> String {
        let id = UUID().uuidString
        
        var aggregator = Aggregator(id: id)
        aggregator.delegate = self
        
        aggregators[id] = aggregator
        
        return id
    }
    
    public func getAggregator(id: String) -> Aggregator? {
        return aggregators[id]
    }
    
    public func handle(command: Command) {
        aggregators[command.aggregatorId]?.handle(command: command)
    }
    
    private var aggregators = [String : Aggregator]()
    private var storage: EventStorage
}

extension Manager: AggregatorDelegate {
    func aggregator(event: Event) {
        storage.save(event: event)
        
        print("event, \(event)")
    }
    
    func notEnoughFunds(aggregatorId: String) {
        print("not enough funds, aggregator = \(aggregatorId)")
    }
    
    func unknown(command: Command) {
        print("unknown command, \(command)")
    }
}
