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
            "Entity Not Found. message: \(message)"
        case .saveFailed(let message):
            "Save Failed. message: \(message)"
        case .readFailed(let message):
            "Read Failed. message: \(message)"
        case .removeFailed(let message):
            "Remove Failed. message: \(message)"
        }
    }
}
