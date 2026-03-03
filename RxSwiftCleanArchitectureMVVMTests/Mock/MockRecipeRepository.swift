//
//  MockRecipeRepository.swift
//  RxSwiftCleanArchitectureMVVMTests
//
//  Created by clapbin on 1/13/26.
//

import Foundation
@testable import RxSwiftCleanArchitectureMVVM

public struct MockRecipeRepository: RecipeRepositoryProtocol {
    public func fetchRecipes(query: String, startIndex: Int, endIndex: Int) async -> Result<RxSwiftCleanArchitectureMVVM.RecipeApiResult, RxSwiftCleanArchitectureMVVM.NetworkError> {
        .failure(.noData)
    }
    
    public func getFavoriteRecipes() -> Result<[RxSwiftCleanArchitectureMVVM.Recipe], RxSwiftCleanArchitectureMVVM.CoreDataError> {
        .failure(.entityNotFound(""))
    }
    
    public func saveFavoriteRecipe(recipe: RxSwiftCleanArchitectureMVVM.Recipe) -> Result<Bool, RxSwiftCleanArchitectureMVVM.CoreDataError> {
        .failure(.saveFailed(""))
    }
    
    public func removeFavoriteRecipe(recipeSequence: String) -> Result<Bool, RxSwiftCleanArchitectureMVVM.CoreDataError> {
        .failure(.removeFailed(""))
    }
    
    
}
