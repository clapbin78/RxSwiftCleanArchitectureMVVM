//
//  NetworkError.swift
//  RxSwiftCleanArchitectureMVVM
//
//  Created by clapbin on 1/5/26.
//

import Foundation

public enum NetworkError: Error {
    case urlSessionError(Error)
    case invalidURL(String)
    case decodingError(Error)
    case noData
    case statusCode(Int)
    case requestFailed(String)
    case unknown
    
    public var description: String {
        switch self {
        case .urlSessionError(let error):
            return error.localizedDescription
        case .invalidURL(let urlString):
            return "Invalid URL: \(urlString)"
        case .decodingError(let error):
            return error.localizedDescription
        case .noData:
            return "No data returned."
        case .statusCode(let code):
            return "Status code: \(code)"
        case .requestFailed(let message):
            return "Request failed: \(message)"
        default:
            return "Unknown error."
        }
    }
}
