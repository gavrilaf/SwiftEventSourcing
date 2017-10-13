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

public struct Aggregator {
    public let id: String
    
    public init(id: String) {
        self.id = id
    }
    
    public var balance: Int {
        return _balance
    }
    
    public init(id: String, withHistory events: Array<Event>) {
        self.id = id
        load(events: events)
    }
    
    public mutating func handle(command: Command) {
        switch command {
        case let deposit as DepositCommand:
            self.deposit(amount: deposit.amount)
        case let withdrawal as WithdrawalCommand:
            self.withdrawal(amount: withdrawal.amount)
        default:
            delegate?.unknown(command: command)
        }
    }
    
    
    weak var delegate: AggregatorDelegate?
    
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
