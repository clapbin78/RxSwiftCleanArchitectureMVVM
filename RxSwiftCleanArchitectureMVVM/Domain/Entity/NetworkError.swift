//
//  NetworkError.swift
//  RxSwiftCleanArchitectureMVVM
//
//  Created by clapbin on 1/5/26.
//

import Foundation

public enum NetworkError: Error {
    case urlError
    case decodingError(String)
    case noData
    case serverErrorStatusCode(Int)
    case requestFailed(String)
    case invalidResponse
    case unknown
    
    public var description: String {
        switch self {
        case .urlError:
            return "URL Error."
        case .decodingError(let description):
            return "Decoding Error: \(description)."
        case .noData:
            return "No data returned."
        case .serverErrorStatusCode(let code):
            return "Server Error Status Code: \(code)."
        case .requestFailed(let message):
            return "Request failed: \(message)"
        case .invalidResponse:
            return "Invalid response."
        default:
            return "Unknown error."
        }
    }
}
