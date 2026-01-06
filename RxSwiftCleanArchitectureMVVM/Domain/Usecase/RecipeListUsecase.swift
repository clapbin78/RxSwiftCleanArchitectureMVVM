//
//  RecipeListUsecase.swift
//  RxSwiftCleanArchitectureMVVM
//
//  Created by clapbin on 1/5/26.
//

import Foundation

public protocol RecipeListUsecaseProtocol {
    func fetchRecipes(query: String, page: Int) async -> Result<RecipeList, NetworkError>
    func getFavoriteRecipes() -> Result<[Recipe], CoreDataError>
    func saveFavoriteRecipe(recipe: Recipe) -> Result<Bool, CoreDataError>
    func removeFavoriteRecipe(recipeId: Int) -> Result<Bool, CoreDataError>
}

public struct RecipeListUsecase: RecipeListUsecaseProtocol {
    private let repository: RecipeRepositoryProtocol
    
    public init(repository: RecipeRepositoryProtocol) {
        self.repository = repository
    }
    
    public func fetchRecipes(query: String, page: Int) async -> Result<RecipeList, NetworkError> {
        await repository.fetchRecipes(query: query, page: page)
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
}
