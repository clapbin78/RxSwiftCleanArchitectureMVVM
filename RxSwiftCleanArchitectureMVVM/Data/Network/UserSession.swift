//
//  UserSession.swift
//  RxSwiftCleanArchitectureMVVM
//
//  Created by clapbin on 1/8/26.
//

import Foundation
import Alamofire

public protocol SessionProtocol {
    func request(_ convertible: URLConvertible,
                 method: HTTPMethod) -> DataRequest
}

class UserSession {
    private var session: Session
    init() {
        let configuration = URLSessionConfiguration.default
        configuration.requestCachePolicy = .returnCacheDataElseLoad
        self.session = Session(configuration: configuration)
    }
    
    func request(_ convertible: URLConvertible,
                 method: HTTPMethod = .get) -> DataRequest {
        return session.request(convertible, method: method)
    }
}
