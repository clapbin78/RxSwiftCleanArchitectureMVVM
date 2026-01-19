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
        let fetchMoreRecipe: Observable<Void>
    }
    
    public struct Output { // VC에게 전달할 뷰 데이터
        let cellData: Observable<[Recipe]>
        let error: Observable<String>
    }
    
    public func transform(input: Input) -> Output { // VC 이벤트 -> VM 데이터
        input.query.bind { query in
            // fetchRecipeList, favoriteRecipeList
        }.disposed(by: disposeBag)
        
        input.saveFavorite
            .bind { recipe in
                // 즐겨찾기 추가
        }.disposed(by: disposeBag)
        
        input.removeFavorite
            .bind { recipeId in
                // 즐겨찾기 제거
        }.disposed(by: disposeBag)
        
        input.fetchMoreRecipe
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
}

public enum TabButtonType {
    case all
    case favorite
}
