//
//  RecipeListViewModelTests.swift
//  RxSwiftCleanArchitectureMVVM
//
//  Created by clapbin on 2/27/26.
//

import Foundation
import XCTest
import RxSwift
import RxCocoa
@testable import RxSwiftCleanArchitectureMVVM

final class RecipeListViewModelTests: XCTestCase {
    private var viewModel: RecipeListViewModel!
    private var mockUsecase: MockRecipeUsecase!
    private var disposeBag: DisposeBag!
    
    private var tabType: BehaviorRelay<TabType>!
    private var query: BehaviorRelay<String>!
    private var saveFavorite: PublishRelay<Recipe>!
    private var removeFavorite: PublishRelay<String>!
    private var fetchMoreRecipeList: PublishRelay<Void>!
    private var input: RecipeListViewModel.Input!
    
    override func setUp() {
        super.setUp()
        mockUsecase = MockRecipeUsecase()
        viewModel = RecipeListViewModel(usecase: mockUsecase)
        tabType = BehaviorRelay(value: .all)
        query = BehaviorRelay<String>(value: "")
        saveFavorite = PublishRelay<Recipe>()
        removeFavorite = PublishRelay<String>()
        fetchMoreRecipeList = PublishRelay<Void>()
        disposeBag = DisposeBag()
        input = RecipeListViewModel.Input(tabType: tabType.asObservable(), query: query.asObservable(), saveFavorite: saveFavorite.asObservable(), removeFavorite: removeFavorite.asObservable(), fetchMoreRecipeList: fetchMoreRecipeList.asObservable())
    }
    
    // 쿼리 결과 cell data로 잘 나오는지
    func testFetchUserCellData() {
        let recipeList = [
            Recipe(recipeSequence: "1", recipeName: "recipe1", bigMainImage: nil, smallMainImage: nil, recipeNatTips: nil, hashTag: nil),
            Recipe(recipeSequence: "2", recipeName: "recipe2", bigMainImage: nil, smallMainImage: nil, recipeNatTips: nil, hashTag: nil),
            Recipe(recipeSequence: "3", recipeName: "recipe3", bigMainImage: nil, smallMainImage: nil, recipeNatTips: nil, hashTag: nil)
        ]
        mockUsecase.fetchRecipeResult = .success(RecipeApiResult(cookRecipes: CookRecipes(totalCount: "3", apiResult: ApiResult(code: "200", message: "success"), recipes: recipeList)))
        
        let output = viewModel.transform(input: input)
        query.accept("recipe")
        
        var result: [RecipeListCellData] = []
        output.cellData.bind { cellData in
            result = cellData
        }.disposed(by: disposeBag)
        
        if case .recipe(let recipe, _) = result.first {
            XCTAssertEqual(recipe.recipeName, "recipe1")
        } else {
            XCTFail("Cell Data 아님")
        }
    }
    
    // 즐겨찾기 결과 cell data로 잘 나오는지
    func testFavoriteCelldata() {
        let recipeList = [
            Recipe(recipeSequence: "1", recipeName: "cake", bigMainImage: nil, smallMainImage: nil, recipeNatTips: nil, hashTag: nil),
            Recipe(recipeSequence: "2", recipeName: "rice", bigMainImage: nil, smallMainImage: nil, recipeNatTips: nil, hashTag: nil),
            Recipe(recipeSequence: "3", recipeName: "pizza", bigMainImage: nil, smallMainImage: nil, recipeNatTips: nil, hashTag: nil)
        ]
        
        mockUsecase.favoriteRecipeResult = .success(recipeList)
        let output = viewModel.transform(input: input)
        tabType.accept(.favorite)
        
        var result: [RecipeListCellData] = []
        output.cellData.bind { cellData in
            result = cellData
        }.disposed(by: disposeBag)
        
        if case .recipe(let recipe, let isFavorite) = result[0] {
            XCTAssertEqual(recipe.recipeName, "cake")
            XCTAssertTrue(isFavorite)
        } else {
            XCTFail("cell data recipe cell 아님")
        }
    }
    
    override func tearDown() {
        disposeBag = nil
        viewModel = nil
        mockUsecase = nil
        super.tearDown()
    }
}
