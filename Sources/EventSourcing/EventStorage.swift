//
//  EventStorage.swift
//  EventSourcing
//
//  Created by Eugen Fedchenko on 10/12/17.
//

import Foundation

protocol EventStorage {
    func loadEvents(forAccount id: String, completion: (Array<Event>) -> Void)
    mutating func save(event: Event)
}

// MARK:
struct InMemoryEventStorage: EventStorage {
    func loadEvents(forAccount id: String, completion: (Array<Event>) -> Void) {
        
    }
    
    mutating func save(event: Event) {
        storage[event.aggregatorId] = event
    }
    
    private var storage = [String : Event]()
}
