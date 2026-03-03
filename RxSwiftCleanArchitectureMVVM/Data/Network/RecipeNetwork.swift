//
//  UserNetwork.swift
//  RxSwiftCleanArchitectureMVVM
//
//  Created by clapbin on 1/8/26.
//

import Foundation

public protocol RecipeNetworkProtocol {
    func fetchRecipes(query: String, startIndex: Int, endIndex: Int) async -> Result<RecipeApiResult, NetworkError>
}

final public class RecipeNetwork: RecipeNetworkProtocol {
    private let manager: NetworkManagerProtocol
    init(manager: NetworkManagerProtocol) {
        self.manager = manager
    }
    
    public func fetchRecipes(query: String, startIndex: Int, endIndex: Int) async -> Result<RecipeApiResult, NetworkError> {
        let url = "https://openapi.foodsafetykorea.go.kr/api/4d8a43b0d46c4a5f84db/COOKRCP01/json/\(startIndex)/\(endIndex)/RCP_NM=\(query)"
        return await manager.fetchData(url: url, method: .get)
    }
}
