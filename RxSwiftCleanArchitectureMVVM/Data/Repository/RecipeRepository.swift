//
//  RecipeRepository.swift
//  RxSwiftCleanArchitectureMVVM
//
//  Created by clapbin on 1/9/26.
//

import Foundation

public struct RecipeRepository: RecipeRepositoryProtocol {
    private let coreData: RecipeCoreDataProtocol, network: RecipeNetworkProtocol
    init(coreData: RecipeCoreDataProtocol, network: RecipeNetworkProtocol) {
        self.coreData = coreData
        self.network = network
    }
    
    public func fetchRecipes(startIndex: Int, endIndex: Int) async -> Result<RecipeList, NetworkError> {
        await network.fetchRecipes(startIndex: startIndex, endIndex: endIndex)
    }
    
    public func getFavoriteRecipes() -> Result<[Recipe], CoreDataError> {
        coreData.getFavoriteRecipes()
    }
    
    public func saveFavoriteRecipe(recipe: Recipe) -> Result<Bool, CoreDataError> {
        coreData.saveFavoriteRecipe(recipe: recipe)
    }
    
    public func removeFavoriteRecipe(recipeId: Int) -> Result<Bool, CoreDataError> {
        coreData.removeFavoriteRecipe(recipeId: recipeId)
    }
    
    
}
