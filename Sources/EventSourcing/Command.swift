//
//  Command.swift
//
//  Created by Eugen Fedchenko on 10/12/17.
//

import Foundation

public enum Command {
    case activate
    case deposit(amount: Int)
    case withdraw(amount: Int)
    case lock
    case unlock
    case close
}
