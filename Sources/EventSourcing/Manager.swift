import Foundation


class Manager {
    
    init(eventStorage: EventStorage) {
        self.storage = eventStorage
    }
    
    func createAggregator() -> String {
        let id = UUID().uuidString
        
        var aggregator = Aggregator(id: id)
        aggregator.delegate = self
        
        aggregators[id] = aggregator
        
        return id
    }
    
    
    func handle(command: Command) {
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
