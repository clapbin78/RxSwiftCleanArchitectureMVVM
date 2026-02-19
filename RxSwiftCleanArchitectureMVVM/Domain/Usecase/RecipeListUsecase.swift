//
//  RecipeListUsecase.swift
//  RxSwiftCleanArchitectureMVVM
//
//  Created by clapbin on 1/5/26.
//

import Foundation

public protocol RecipeListUsecaseProtocol {
    func fetchRecipes(query: String, startIndex: Int, endIndex: Int) async -> Result<RecipeApiResult, NetworkError>
    func getFavoriteRecipes() -> Result<[Recipe], CoreDataError>
    func saveFavoriteRecipe(recipe: Recipe) -> Result<Bool, CoreDataError>
    func removeFavoriteRecipe(recipeSequence: String) -> Result<Bool, CoreDataError>
    func checkFavoriteState(fetchRecipes: [Recipe], favoriteRecipes: [Recipe]) -> [(recipe: Recipe, isFavorite: Bool)]
    func convertListToDictionary(favoriteRecipes: [Recipe]) -> [String: [Recipe]]
}

public struct RecipeListUsecase: RecipeListUsecaseProtocol {
    private let repository: RecipeRepositoryProtocol
    
    public init(repository: RecipeRepositoryProtocol) {
        self.repository = repository
    }
    
    public func fetchRecipes(query: String,startIndex: Int, endIndex: Int) async -> Result<RecipeApiResult, NetworkError> {
        await repository.fetchRecipes(query: query, startIndex: startIndex, endIndex: endIndex)
    }
    
    public func getFavoriteRecipes() -> Result<[Recipe], CoreDataError> {
        repository.getFavoriteRecipes()
    }
    
    public func saveFavoriteRecipe(recipe: Recipe) -> Result<Bool, CoreDataError> {
        repository.saveFavoriteRecipe(recipe: recipe)
    }
    
    public func removeFavoriteRecipe(recipeSequence: String) -> Result<Bool, CoreDataError> {
        repository.removeFavoriteRecipe(recipeSequence: recipeSequence)
    }
    
    public func checkFavoriteState(fetchRecipes: [Recipe], favoriteRecipes: [Recipe]) -> [(recipe: Recipe, isFavorite: Bool)] {
        let favoriteSet = Set(favoriteRecipes)
        return fetchRecipes.map { recipe in
            if favoriteSet.contains(recipe) {
                return (recipe: recipe, isFavorite: true)
            } else {
                return (recipe: recipe, isFavorite: false)
            }
        }
    }
    
    public func convertListToDictionary(favoriteRecipes: [Recipe]) -> [String : [Recipe]] {
        return favoriteRecipes.reduce(into: [String: [Recipe]]()) { dict, recipe in
            if let firstString = recipe.recipeName.first {
                let key = String(firstString).uppercased()
                dict[key, default: []].append(recipe)
            }
        }
    }
}
