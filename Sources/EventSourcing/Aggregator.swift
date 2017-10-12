//
//  Aggregator.swift
//  EventSourcingPackageDescription
//
//  Created by Eugen Fedchenko on 10/12/17.
//

import Foundation

protocol AggregatorDelegate: class {
    func aggregator(event: Event)
    
    func notEnoughFunds(aggregatorId: String)
    func unknown(command: Command)
}

struct Aggregator {
    let id: String
    
    weak var delegate: AggregatorDelegate?
    
    init(id: String) {
        self.id = id
    }
    
    init(id: String, withHistory events: Array<Event>) {
        self.id = id
        load(events: events)
    }
    
    mutating func handle(command: Command) {
        switch command {
        case let deposit as DepositCommand:
            self.deposit(amount: deposit.amount)
        case let withdrawal as WithdrawalCommand:
            self.withdrawal(amount: withdrawal.amount)
        default:
            delegate?.unknown(command: command)
        }
    }
    
    
    private mutating func deposit(amount: Int) {
        _balance += amount
        delegate?.aggregator(event: DepositEvent(aggregatorId: id, amount: amount))
    }
    
    private mutating func withdrawal(amount: Int) {
        if _balance >= amount {
            _balance -= amount
            delegate?.aggregator(event: WithdrawalEvent(aggregatorId: id, amount: amount))
        } else {
            delegate?.notEnoughFunds(aggregatorId: id)
        }
    }
    
    private func load(events: Array<Event>) {
        
    }
    
    private var _balance: Int = 0
}
