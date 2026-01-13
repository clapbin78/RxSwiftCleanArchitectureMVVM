//
//  RecipeUsecaseTests.swift
//  RxSwiftCleanArchitectureMVVMTests
//
//  Created by clapbin on 1/13/26.
//

import XCTest
@testable import RxSwiftCleanArchitectureMVVM

final class RecipeUsecaseTests: XCTestCase {
    var usecase: RecipeListUsecaseProtocol!
    var repository: RecipeRepositoryProtocol!
    
    override func setUp() {
        super.setUp()
        repository = MockRecipeRepository()
        usecase = RecipeListUsecase(repository: repository)
    }
    
    func testCheckFavoriteStatus() {
        let favoriteRecipes = [
            Recipe(id: 1, recipeName: "콩나물무침", recipeParts: "콩나물", recipeWay: "무침", recipePat: "150", infoWeight: "150g", infoEnergy: "150", infoCar: "150", infoPro: "15", infoFat: "15", infoNa: "10", bigMainImage: nil, smallMainImage: nil, recipeNatTips: nil, hashTag: nil),
            Recipe(id: 2, recipeName: "두부무침", recipeParts: "두부", recipeWay: "무침", recipePat: "150", infoWeight: "150g", infoEnergy: "150", infoCar: "150", infoPro: "15", infoFat: "15", infoNa: "10", bigMainImage: nil, smallMainImage: nil, recipeNatTips: nil, hashTag: nil)
        ]
        
        let fetchRecipes = [
            Recipe(id: 1, recipeName: "콩나물무침", recipeParts: "콩나물", recipeWay: "무침", recipePat: "150", infoWeight: "150g", infoEnergy: "150", infoCar: "150", infoPro: "15", infoFat: "15", infoNa: "10", bigMainImage: nil, smallMainImage: nil, recipeNatTips: nil, hashTag: nil),
            Recipe(id: 3, recipeName: "장조림", recipeParts: "소고기", recipeWay: "조림", recipePat: "150", infoWeight: "150g", infoEnergy: "150", infoCar: "150", infoPro: "150", infoFat: "150", infoNa: "10", bigMainImage: nil, smallMainImage: nil, recipeNatTips: nil, hashTag: nil)
        ]
        
        let result = usecase.checkFavoriteStatus(fetchRecipes: fetchRecipes, favoriteRecipes: favoriteRecipes)
        
        XCTAssertEqual(result[0].isFavorite, true)
        XCTAssertEqual(result[1].isFavorite, false)
    }
    
    func testConvertListToDictionary() {
        let recipes = [
            Recipe(id: 1, recipeName: "creampasta", recipeParts: "cream", recipeWay: "pasta", recipePat: "150", infoWeight: "150g", infoEnergy: "150", infoCar: "150", infoPro: "15", infoFat: "15", infoNa: "10", bigMainImage: nil, smallMainImage: nil, recipeNatTips: nil, hashTag: nil),
            Recipe(id: 2, recipeName: "cheesePizza", recipeParts: "cheese", recipeWay: "broil", recipePat: "150", infoWeight: "150g", infoEnergy: "150", infoCar: "150", infoPro: "15", infoFat: "15", infoNa: "10", bigMainImage: nil, smallMainImage: nil, recipeNatTips: nil, hashTag: nil),
            Recipe(id: 3, recipeName: "Oilpasta", recipeParts: "oil", recipeWay: "pasta", recipePat: "150", infoWeight: "150g", infoEnergy: "150", infoCar: "150", infoPro: "15", infoFat: "15", infoNa: "10", bigMainImage: nil, smallMainImage: nil, recipeNatTips: nil, hashTag: nil),
            Recipe(id: 4, recipeName: "BEEFBURGER", recipeParts: "beef", recipeWay: "buger", recipePat: "150", infoWeight: "150g", infoEnergy: "150", infoCar: "150", infoPro: "15", infoFat: "15", infoNa: "10", bigMainImage: nil, smallMainImage: nil, recipeNatTips: nil, hashTag: nil)
        ]
        let result = usecase.convertListToDictionary(favoriteRecipes: recipes)
        
        XCTAssertEqual(result.keys.count, 3)
        if let resultA = result["A"] {
            XCTAssertEqual(resultA.count, 0)
        }
        if let resultB = result["B"] {
            XCTAssertEqual(resultB.count, 1)
        }
        if let resultC = result["C"] {
            XCTAssertEqual(resultC.count, 2)
        }
    }
    
    override func tearDown() {
        repository = nil
        usecase = nil
        super.tearDown()
    }
}
