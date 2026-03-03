//
//  MockRecipeUsecase.swift
//  RxSwiftCleanArchitectureMVVM
//
//  Created by clapbin on 2/27/26.
//

import Foundation
@testable import RxSwiftCleanArchitectureMVVM

public class MockRecipeUsecase: RecipeListUsecaseProtocol {
    
    public var fetchRecipeResult: Result<RecipeApiResult, NetworkError>?
    public var favoriteRecipeResult: Result<[Recipe], CoreDataError>?
    
    public func fetchRecipes(query: String, startIndex: Int, endIndex: Int) async -> Result<RxSwiftCleanArchitectureMVVM.RecipeApiResult, RxSwiftCleanArchitectureMVVM.NetworkError> {
        fetchRecipeResult ?? .failure(.noData)
    }
    
    public func getFavoriteRecipes() -> Result<[RxSwiftCleanArchitectureMVVM.Recipe], RxSwiftCleanArchitectureMVVM.CoreDataError> {
        favoriteRecipeResult ?? .failure(.entityNotFound(""))
    }
    
    public func saveFavoriteRecipe(recipe: RxSwiftCleanArchitectureMVVM.Recipe) -> Result<Bool, RxSwiftCleanArchitectureMVVM.CoreDataError> {
        .success(true)
    }
    
    public func removeFavoriteRecipe(recipeSequence: String) -> Result<Bool, RxSwiftCleanArchitectureMVVM.CoreDataError> {
        .success(true)
    }
    
    public func checkFavoriteState(fetchRecipes: [Recipe], favoriteRecipes: [Recipe]) -> [(recipe: Recipe, isFavorite: Bool)] {
        let recipeSequences = Set(favoriteRecipes.map { $0.recipeSequence })
        return fetchRecipes.map { recipe in
            return (recipe: recipe, isFavorite: recipeSequences.contains(recipe.recipeSequence))
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
