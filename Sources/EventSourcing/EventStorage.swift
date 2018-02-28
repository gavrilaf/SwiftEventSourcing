//
//  EventStorage.swift
//
//  Created by Eugen Fedchenko on 10/12/17.
//

import Foundation

public protocol EventStorage {
    func save(account id: String)
    func save(event: Event, forAccount id: String)
    
    func getAccounts() -> Array<String>
    func getEvents(forAccount id: String) -> Array<Event>
}

// MARK:

public class InMemoryEventStorage: EventStorage {
    
    public init() {}
    
    public func save(account id: String) {
        events[id] = []
    }
    
    public func save(event: Event, forAccount id: String) {
        events[id]?.append(event)
    }
    
    public func getAccounts() -> Array<String> {
        return Array(events.keys)
    }
    
    public func getEvents(forAccount id: String) -> Array<Event> {
        return events[id] ?? []
    }
    
    private var events = [String: Array<Event>]()
}

