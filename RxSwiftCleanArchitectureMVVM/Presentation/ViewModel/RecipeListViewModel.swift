//
//  RecipeListViewModel.swift
//  RxSwiftCleanArchitectureMVVM
//
//  Created by clapbin on 1/19/26.
//

import Foundation
import RxSwift
import RxCocoa

protocol RecipeListViewModelProtocol {
    
}

public final class RecipeListViewModel: RecipeListViewModelProtocol {
    private let usecase: RecipeListUsecaseProtocol
    private let disposeBag = DisposeBag()
    private let error = PublishRelay<String>()
    private let fetchRecipeList = BehaviorRelay<[Recipe]>(value: [])
    private let allFavoriteRecipeList = BehaviorRelay<[Recipe]>(value: []) // fetchRecipe 즐겨찾기 여부를 위한 전체목록
    private let favoriteRecipeList = BehaviorRelay<[Recipe]>(value: []) // 목록에 보여줄 리스트
    
    public init(usecase: RecipeListUsecase) {
        self.usecase = usecase
    }
    
    public struct Input { // VM에게 전달되어야 할 이벤트
        let tabButtonType: Observable<TabButtonType>
        let query: Observable<String>
        let saveFavorite: Observable<Recipe>
        let removeFavorite: Observable<Int>
        let fetchMoreRecipeList: Observable<Void>
    }
    
    public struct Output { // VC에게 전달할 뷰 데이터
        let cellData: Observable<[Recipe]>
        let error: Observable<String>
    }
    
    public func transform(input: Input) -> Output { // VC 이벤트 -> VM 데이터
        input.query.bind { [weak self] query in
            // fetchRecipeList, favoriteRecipeList
            guard let isValidate = self?.validateQuery(query: query), isValidate else {
                self?.getFavoriteRecipes(query: "")
                return
            }
            self?.fetchRecipes(query: query, startIndex: 0, endIndex: 0)
            self?.getFavoriteRecipes(query: query)
        }.disposed(by: disposeBag)
        
        input.saveFavorite
            .withLatestFrom(input.query, resultSelector: { recipes, query in
                return (recipes, query) })
            .bind { [weak self] recipe, query in
                // 즐겨찾기 추가
                self?.saveFavoriteRecipe(query: query, recipe: recipe)
            }.disposed(by: disposeBag)
        
        input.removeFavorite
            .withLatestFrom(input.query, resultSelector: { ($0, $1)})
            .bind { [weak self] recipeId, query in
                // 즐겨찾기 제거
                self?.removeFavoriteRecipe(query: query, recipeId: recipeId)
            }.disposed(by: disposeBag)
        
        input.fetchMoreRecipeList
            .bind {
                // 다음 페이지 fetch
        }.disposed(by: disposeBag)
        
        // 탭 레시피 리스트, 즐겨찾기 리스트
        let cellData: Observable<[Recipe]> = Observable.combineLatest(input.tabButtonType, fetchRecipeList, favoriteRecipeList).map { tabButtonType, fetchRecipeList, favoriteRecipeList in
            let cellData: [Recipe] = []
            // cellData 생성
            return cellData
        }
        
        return Output(cellData: cellData, error: error.asObservable())
    }
    
    private func fetchRecipes(query: String, startIndex: Int, endIndex: Int) {
        guard let urlAllowedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        Task {
            let result = await usecase.fetchRecipes(startIndex: startIndex, endIndex: endIndex)
            switch result {
            case let .success(recipes):
                if let recipes = recipes.recipes {
                    if startIndex == 0 {
                        fetchRecipeList.accept(recipes)
                    } else {
                        fetchRecipeList.accept(fetchRecipeList.value + recipes)
                    }
                }
            case let .failure(error):
                self.error.accept(error.description)
            }
        }
    }
    
    private func getFavoriteRecipes(query: String) {
        let result = usecase.getFavoriteRecipes()
        switch result {
        case .success(let recipes):
            if query.isEmpty {
                favoriteRecipeList.accept(recipes)
            } else {
                let filteredRecipes = recipes.filter {
                    $0.recipeName.contains(query)
                }
                favoriteRecipeList.accept(filteredRecipes)
            }
            allFavoriteRecipeList.accept(recipes)
        case .failure(let error):
            self.error.accept(error.description)
        }
    }
    
    private func saveFavoriteRecipe(query: String, recipe: Recipe) {
        let result = usecase.saveFavoriteRecipe(recipe: recipe)
        switch result {
        case .success:
             getFavoriteRecipes(query: query)
        case let .failure(error):
            self.error.accept(error.description)
        }
    }
    
    private func removeFavoriteRecipe(query: String, recipeId: Int) {
        let result = usecase.removeFavoriteRecipe(recipeId: recipeId)
        switch result {
        case .success:
            getFavoriteRecipes(query: query)
        case let .failure(error):
            self.error.accept(error.description)
        }
    }
    
    private func validateQuery(query: String) -> Bool {
        if query.isEmpty {
            return false
        } else {
            return true
        }
    }
}

public enum TabButtonType {
    case all
    case favorite
}
