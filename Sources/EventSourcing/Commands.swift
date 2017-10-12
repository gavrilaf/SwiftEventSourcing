//
//  Commands.swift
//  EventSourcingPackageDescription
//
//  Created by Eugen Fedchenko on 10/12/17.
//

import Foundation

protocol Command {
    var aggregatorId: String { get }
}

// MARK:
struct DepositCommand : Command {
    let aggregatorId: String
    let amount: Int
}

// MARK:
struct WithdrawalCommand: Command {
    let aggregatorId: String
    let amount: Int
}
