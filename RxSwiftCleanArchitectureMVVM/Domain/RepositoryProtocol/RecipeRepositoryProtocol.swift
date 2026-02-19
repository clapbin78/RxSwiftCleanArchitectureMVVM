//
//  RecipeRepositoryProtocol.swift
//  RxSwiftCleanArchitectureMVVM
//
//  Created by clapbin on 1/5/26.
//

import Foundation

public protocol RecipeRepositoryProtocol {
    func fetchRecipes(query: String, startIndex: Int, endIndex: Int) async -> Result<RecipeApiResult, NetworkError>
    func getFavoriteRecipes() -> Result<[Recipe], CoreDataError>
    func saveFavoriteRecipe(recipe: Recipe) -> Result<Bool, CoreDataError>
    func removeFavoriteRecipe(recipeSequence: String) -> Result<Bool, CoreDataError>
}
