//
//  NetworkManager.swift
//  RxSwiftCleanArchitectureMVVM
//
//  Created by clapbin on 1/8/26.
//

import Foundation
import Alamofire

protocol NetworkManagerProtocol {
    func fetchData<T: Decodable>(url: String, method: HTTPMethod) async -> Result<T, NetworkError>
}

public class NetworkManager {
    private let session: SessionProtocol
    
    init(session: SessionProtocol) {
        self.session = session
    }
    
    func fetchData<T: Decodable>(url: String, method: HTTPMethod) async -> Result<T, NetworkError> {
        guard let url = URL(string: url) else {
            return .failure(.urlError)
        }
        
        let result = await session.request(url, method: method).serializingData().response
        
        if let error = result.error { return .failure(.requestFailed(error.localizedDescription)) }
        guard let data = result.data else { return .failure(.noData) }
        guard let response = result.response else { return .failure(.invalidResponse) }
        if 200..<400 ~= response.statusCode {
            do {
                let data = try JSONDecoder().decode(T.self, from: data)
                return .success(data)
            } catch {
                return .failure(.decodingError(error.localizedDescription))
            }
        } else {
            return .failure(.serverErrorStatusCode(response.statusCode))
        }
    }
}
