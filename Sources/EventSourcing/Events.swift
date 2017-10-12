//
//  Events.swift
//  EventSourcingPackageDescription
//
//  Created by Eugen Fedchenko on 10/12/17.
//

import Foundation

protocol Event {
    var aggregatorId: String { get }
}

// MARK:
struct DepositEvent : Event {
    let aggregatorId: String
    let amount: Int
}

// MARK:
struct WithdrawalEvent: Event {
    let aggregatorId: String
    let amount: Int
}
