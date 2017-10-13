//
//  Events.swift
//  EventSourcingPackageDescription
//
//  Created by Eugen Fedchenko on 10/12/17.
//

import Foundation

public protocol Event {
    var aggregatorId: String { get }
}

// MARK:
public struct DepositEvent : Event {
    public let aggregatorId: String
    public let amount: Int
}

// MARK:
public struct WithdrawalEvent: Event {
    public let aggregatorId: String
    public let amount: Int
}
