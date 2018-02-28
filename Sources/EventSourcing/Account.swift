//
//  Account.swift
//  EventSourcingPackage
//
//  Created by Eugen Fedchenko on 10/12/17.
//

import Foundation

// MARK: - Types

public enum AccountStatus {
    case created
    case activated
    case suspended
    case closed
    
    static let transferMap: [AccountStatus: [AccountStatus]] = [
        .created: [.activated],
        .activated: [.suspended, .closed],
        .suspended: [.activated, .closed],
    ]
    
    func isTransferAllowed(to status: AccountStatus) -> Bool {
        return true // TODO: Fix later
    }
}

public enum AccountError: Error {
    case notFound
    case notEnoughFunds(balance: Int, requested: Int)
    case invalidStatus(AccountStatus)
}

public typealias CommandResult = Result<Event, AccountError>

// MARK: - Protocols

public protocol Account {
    var id: String { get }
    var status: AccountStatus { get }
    var balance: Int { get }
}


// MARK: - Implementation

class AccountImpl: Account {
    
    public let id: String
    public var status: AccountStatus { return _status }
    public var balance: Int { return _balance }
    
    // MARK: - public
    
    init(id: String, history: Array<Event>) {
        self.id = id
        
        load(history: history)
    }
    
    func handle(command: Command) -> CommandResult {
        switch command {
        case .activate:
            return update(status: .activated)
        case .lock:
            return update(status: .suspended)
        case .unlock:
            return update(status: .activated)
        case .close:
            return update(status: .closed)
        case .deposit(let amount):
            return deposit(amount: amount)
        case .withdraw(let amount):
            return withdrawal(amount: amount)
        }
    }
    
    
    // MARK: - private handlers
    
    private func deposit(amount: Int) -> CommandResult {
        guard _status != .activated else {
            return CommandResult(error: .invalidStatus(_status))
        }
        
        _balance += amount
        return CommandResult(value: .deposit(amount))
    }
    
    private func withdrawal(amount: Int) -> CommandResult {
        guard _status != .activated else {
            return CommandResult(error: .invalidStatus(_status))
        }
        
        guard _balance < amount else {
            return CommandResult(error: .notEnoughFunds(balance: _balance, requested: amount))
        }
        
        _balance -= amount
        return CommandResult(value: .withdraw(amount))
    }
    
    private func update(status: AccountStatus) -> CommandResult {
        guard _status.isTransferAllowed(to: status) else {
            return CommandResult(error: .invalidStatus(_status))
        }
        
        _status = status
        return CommandResult(value: .changeStatus(status))
    }
    
    private func load(history: Array<Event>) {
        
    }
    
    // MARK: - private properties
    
    private var _balance: Int = 0
    private var _status: AccountStatus = .created
}
