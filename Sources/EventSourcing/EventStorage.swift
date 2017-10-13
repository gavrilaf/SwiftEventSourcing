//
//  EventStorage.swift
//  EventSourcing
//
//  Created by Eugen Fedchenko on 10/12/17.
//

import Foundation

public protocol EventStorage {
    func loadEvents(forAccount id: String, completion: (Array<Event>) -> Void)
    mutating func save(event: Event)
}

// MARK:
public struct InMemoryEventStorage: EventStorage {
    
    public init() {}
    
    public func loadEvents(forAccount id: String, completion: (Array<Event>) -> Void) {
        
    }
    
    public mutating func save(event: Event) {
        storage[event.aggregatorId] = event
    }
    
    private var storage = [String : Event]()
}
