//
//  Commands.swift
//  EventSourcingPackageDescription
//
//  Created by Eugen Fedchenko on 10/12/17.
//

import Foundation

public protocol Command {
    var aggregatorId: String { get }
}

// MARK:
public struct DepositCommand : Command {
    
    public init(aggregator id: String, amount: Int) {
        self.aggregatorId = id
        self.amount = amount
    }
    
    public let aggregatorId: String
    public let amount: Int
}

// MARK:
public struct WithdrawalCommand: Command {
    
    public init(aggregator id: String, amount: Int) {
        self.aggregatorId = id
        self.amount = amount
    }
    
    public let aggregatorId: String
    public let amount: Int
}
