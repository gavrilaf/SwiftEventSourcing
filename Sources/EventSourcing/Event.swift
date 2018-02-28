//
//  Event.swift
//
//  Created by Eugen Fedchenko on 10/12/17.
//

import Foundation

public enum Event {
    case deposit(Int)
    case withdraw(Int)
    case changeStatus(AccountStatus)
}


