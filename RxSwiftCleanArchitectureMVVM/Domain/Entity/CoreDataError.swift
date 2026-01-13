//
//  CoreDataError.swift
//  RxSwiftCleanArchitectureMVVM
//
//  Created by clapbin on 1/5/26.
//

import Foundation

public enum CoreDataError: Error {
    case entityNotFound(String)
    case saveFailed(String)
    case readFailed(String)
    case removeFailed(String)
    
    public var description: String {
        switch self {
        case .entityNotFound(let message):
            return message
        case .saveFailed(let message):
            return message
        case .readFailed(let message):
            return message
        case .removeFailed(let message):
            return message
        }
    }
}
