//
//  RecipeListUsecase.swift
//  RxSwiftCleanArchitectureMVVM
//
//  Created by clapbin on 1/5/26.
//

import Foundation

public protocol RecipeListUsecaseProtocol {
    func fetchRecipes(startIndex: Int, endIndex: Int) async -> Result<RecipeList, NetworkError>
    func getFavoriteRecipes() -> Result<[Recipe], CoreDataError>
    func saveFavoriteRecipe(recipe: Recipe) -> Result<Bool, CoreDataError>
    func removeFavoriteRecipe(recipeId: Int) -> Result<Bool, CoreDataError>
    func checkFavoriteStatus(fetchRecipes: [Recipe], favoriteRecipes: [Recipe]) -> [(recipe: Recipe, isFavorite: Bool)]
    func convertListToDictionary(favoriteRecipes: [Recipe]) -> [String: [Recipe]]
}

public struct RecipeListUsecase: RecipeListUsecaseProtocol {
    private let repository: RecipeRepositoryProtocol
    
    public init(repository: RecipeRepositoryProtocol) {
        self.repository = repository
    }
    
    public func fetchRecipes(startIndex: Int, endIndex: Int) async -> Result<RecipeList, NetworkError> {
        await repository.fetchRecipes(startIndex: startIndex, endIndex: endIndex)
    }
    
    public func getFavoriteRecipes() -> Result<[Recipe], CoreDataError> {
        // 일단 failure로 해놓음
        .failure(.readFailed(""))
    }
    
    public func saveFavoriteRecipe(recipe: Recipe) -> Result<Bool, CoreDataError> {
        // 일단 failure로 해놓음
        .failure(.saveFailed(""))
    }
    
    public func removeFavoriteRecipe(recipeId: Int) -> Result<Bool, CoreDataError> {
        // 일단 failure로 해놓음
        .failure(.deleteFailed(""))
    }
    
    public func checkFavoriteStatus(fetchRecipes: [Recipe], favoriteRecipes: [Recipe]) -> [(recipe: Recipe, isFavorite: Bool)] {
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
