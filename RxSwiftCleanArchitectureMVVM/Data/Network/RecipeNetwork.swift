//
//  UserNetwork.swift
//  RxSwiftCleanArchitectureMVVM
//
//  Created by clapbin on 1/8/26.
//

import Foundation

public protocol RecipeNetworkProtocol {
    func fetchRecipes(startIndex: Int, endIndex: Int) async -> Result<RecipeList, NetworkError>
}

final public class RecipeNetwork {
    private let manager: NetworkManagerProtocol
    init(manager: NetworkManagerProtocol) {
        self.manager = manager
    }
    
    func fetchRecipes(startIndex: Int, endIndex: Int) async -> Result<RecipeList, NetworkError> {
        let url = "http://openapi.foodsafetykorea.go.kr/api/{personalAuthenticationKey}/COOKRCP01/json/\(startIndex)/\(endIndex)"
        return await manager.fetchData(url: url, method: .get)
    }
}
