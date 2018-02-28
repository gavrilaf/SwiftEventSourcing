//
//  Result.swift
//
//  Created by Eugen Fedchenko on 2/28/18.
//

import Foundation

//  In production I would use package Result, but in demo project it's good idea to minimize dependencies
public enum Result<Value, Error: Swift.Error> {
    case success(Value)
    case failure(Error)
    
    init(value: Value) {
        self = .success(value)
    }
    
    init(error: Error) {
        self = .failure(error)
    }
    
    public func flatMap<U>(_ transform: (Value) -> Result<U, Error>) -> Result<U, Error> {
        switch self {
        case let .success(value): return transform(value)
        case let .failure(error): return .failure(error)
        }
    }
    
    public func flatMapError<Error2>(_ transform: (Error) -> Result<Value, Error2>) -> Result<Value, Error2> {
        switch self {
        case let .success(value): return .success(value)
        case let .failure(error): return transform(error)
        }
    }
}
