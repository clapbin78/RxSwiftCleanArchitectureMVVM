//
//  RecipeCoreData.swift
//  RxSwiftCleanArchitectureMVVM
//
//  Created by clapbin on 1/9/26.
//

import Foundation
import CoreData

public protocol RecipeCoreDataProtocol {
    func getFavoriteRecipes() -> Result<[Recipe], CoreDataError>
    func saveFavoriteRecipe(recipe: Recipe) -> Result<Bool, CoreDataError>
    func removeFavoriteRecipe(recipeSequence: String) -> Result<Bool, CoreDataError>
}

public struct RecipeCoreData: RecipeCoreDataProtocol {
    private let viewContext: NSManagedObjectContext
    init(viewContext: NSManagedObjectContext) {
        self.viewContext = viewContext
    }
    
    public func getFavoriteRecipes() -> Result<[Recipe], CoreDataError> {
        let fetchRequest: NSFetchRequest<FavoriteRecipe> = FavoriteRecipe.fetchRequest()
        do {
            let result = try viewContext.fetch(fetchRequest)
            let recipeList: [Recipe] = result.compactMap { favoriteRecipe in
                guard let recipeSequence = favoriteRecipe.recipeSequence, let recipeName = favoriteRecipe.recipeName else { return nil }
                
                return Recipe(recipeSequence: recipeSequence, recipeName: recipeName, recipeParts: favoriteRecipe.recipeParts, recipeWay: favoriteRecipe.recipeWay, recipePat: favoriteRecipe.recipePat,
                              infoWeight: favoriteRecipe.infoWeight, infoEnergy: favoriteRecipe.infoEnergy, infoCar: favoriteRecipe.infoCar, infoPro: favoriteRecipe.infoPro, infoFat: favoriteRecipe.infoFat, infoNa: favoriteRecipe.infoNa,
                              bigMainImage: favoriteRecipe.bigMainImage, smallMainImage: favoriteRecipe.smallMainImage, recipeNatTips: favoriteRecipe.recipeNatTips, hashTag: favoriteRecipe.hashTag,
                              manual01: favoriteRecipe.manual01, manual02: favoriteRecipe.manual02, manual03: favoriteRecipe.manual03, manual04: favoriteRecipe.manual04, manual05: favoriteRecipe.manual05, manual06: favoriteRecipe.manual06, manual07: favoriteRecipe.manual07, manual08: favoriteRecipe.manual08, manual09: favoriteRecipe.manual09, manual10: favoriteRecipe.manual10, manual11: favoriteRecipe.manual11, manual12: favoriteRecipe.manual12, manual13: favoriteRecipe.manual13, manual14: favoriteRecipe.manual14, manual15: favoriteRecipe.manual15, manual16: favoriteRecipe.manual16, manual17: favoriteRecipe.manual17, manual18: favoriteRecipe.manual18, manual19: favoriteRecipe.manual19, manual20: favoriteRecipe.manual20,
                              manualImg01: favoriteRecipe.manualImg01, manualImg02: favoriteRecipe.manualImg02, manualImg03: favoriteRecipe.manualImg03, manualImg04: favoriteRecipe.manualImg04, manualImg05: favoriteRecipe.manualImg05, manualImg06: favoriteRecipe.manualImg06, manualImg07: favoriteRecipe.manualImg07, manualImg08: favoriteRecipe.manualImg08, manualImg09: favoriteRecipe.manualImg09, manualImg10: favoriteRecipe.manualImg10, manualImg11: favoriteRecipe.manualImg11, manualImg12: favoriteRecipe.manualImg12, manualImg13: favoriteRecipe.manualImg13, manualImg14: favoriteRecipe.manualImg14, manualImg15: favoriteRecipe.manualImg15, manualImg16: favoriteRecipe.manualImg16, manualImg17: favoriteRecipe.manualImg18, manualImg19: favoriteRecipe.manualImg19, manualImg20: favoriteRecipe.manualImg20)
            }
            return.success(recipeList)
        } catch {
            return .failure(.readFailed(error.localizedDescription))
        }
        
    }
    
    public func saveFavoriteRecipe(recipe: Recipe) -> Result<Bool, CoreDataError> {
        guard let entity = NSEntityDescription.entity(forEntityName: "FavoriteRecipe", in: viewContext) else {
            return .failure(.entityNotFound("FavoriteRecipe entity not found"))
        }
        let recipeObject = NSManagedObject(entity: entity, insertInto: viewContext)
        recipeObject.setValue(recipe.recipeSequence, forKey: "recipeSequence")
        recipeObject.setValue(recipe.recipeName, forKey: "recipeName")
        recipeObject.setValue(recipe.recipeParts, forKey: "recipeParts")
        recipeObject.setValue(recipe.recipeWay, forKey: "recipeWay")
        recipeObject.setValue(recipe.recipePat, forKey: "recipePat")
        recipeObject.setValue(recipe.infoWeight, forKey: "infoWeight")
        recipeObject.setValue(recipe.infoEnergy, forKey: "infoEnergy")
        recipeObject.setValue(recipe.infoCar, forKey: "infoCar")
        recipeObject.setValue(recipe.infoPro, forKey: "infoPro")
        recipeObject.setValue(recipe.infoFat, forKey: "infoFat")
        recipeObject.setValue(recipe.infoNa, forKey: "infoNa")
        recipeObject.setValue(recipe.bigMainImage, forKey: "bigMainImage")
        recipeObject.setValue(recipe.smallMainImage, forKey: "smallMainImage")
        recipeObject.setValue(recipe.recipeNatTips, forKey: "recipeNatTips")
        recipeObject.setValue(recipe.hashTag, forKey: "hashTag")
        recipeObject.setValue(recipe.manual01, forKey: "manual01")
        recipeObject.setValue(recipe.manual02, forKey: "manual02")
        recipeObject.setValue(recipe.manual03, forKey: "manual03")
        recipeObject.setValue(recipe.manual04, forKey: "manual04")
        recipeObject.setValue(recipe.manual05, forKey: "manual05")
        recipeObject.setValue(recipe.manual06, forKey: "manual06")
        recipeObject.setValue(recipe.manual07, forKey: "manual07")
        recipeObject.setValue(recipe.manual08, forKey: "manual08")
        recipeObject.setValue(recipe.manual09, forKey: "manual09")
        recipeObject.setValue(recipe.manual10, forKey: "manual10")
        recipeObject.setValue(recipe.manual11, forKey: "manual11")
        recipeObject.setValue(recipe.manual12, forKey: "manual12")
        recipeObject.setValue(recipe.manual13, forKey: "manual13")
        recipeObject.setValue(recipe.manual14, forKey: "manual14")
        recipeObject.setValue(recipe.manual15, forKey: "manual15")
        recipeObject.setValue(recipe.manual16, forKey: "manual16")
        recipeObject.setValue(recipe.manual17, forKey: "manual17")
        recipeObject.setValue(recipe.manual18, forKey: "manual18")
        recipeObject.setValue(recipe.manual19, forKey: "manual19")
        recipeObject.setValue(recipe.manual20, forKey: "manual20")
        recipeObject.setValue(recipe.manualImg01, forKey: "manualImg01")
        recipeObject.setValue(recipe.manualImg02, forKey: "manualImg02")
        recipeObject.setValue(recipe.manualImg03, forKey: "manualImg03")
        recipeObject.setValue(recipe.manualImg04, forKey: "manualImg04")
        recipeObject.setValue(recipe.manualImg05, forKey: "manualImg05")
        recipeObject.setValue(recipe.manualImg06, forKey: "manualImg06")
        recipeObject.setValue(recipe.manualImg07, forKey: "manualImg07")
        recipeObject.setValue(recipe.manualImg08, forKey: "manualImg08")
        recipeObject.setValue(recipe.manualImg09, forKey: "manualImg09")
        recipeObject.setValue(recipe.manualImg10, forKey: "manualImg10")
        recipeObject.setValue(recipe.manualImg11, forKey: "manualImg11")
        recipeObject.setValue(recipe.manualImg12, forKey: "manualImg12")
        recipeObject.setValue(recipe.manualImg13, forKey: "manualImg13")
        recipeObject.setValue(recipe.manualImg14, forKey: "manualImg14")
        recipeObject.setValue(recipe.manualImg15, forKey: "manualImg15")
        recipeObject.setValue(recipe.manualImg16, forKey: "manualImg16")
        recipeObject.setValue(recipe.manualImg17, forKey: "manualImg17")
        recipeObject.setValue(recipe.manualImg18, forKey: "manualImg18")
        recipeObject.setValue(recipe.manualImg19, forKey: "manualImg19")
        recipeObject.setValue(recipe.manualImg20, forKey: "manualImg20")
        
        do {
            try viewContext.save()
            return .success(true)
        } catch {
            return .failure(.saveFailed(error.localizedDescription))
        }
    }
    
    public func removeFavoriteRecipe(recipeSequence: String) -> Result<Bool, CoreDataError> {
        let fetchRequest: NSFetchRequest<FavoriteRecipe> = FavoriteRecipe.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "recipeSequence == %@", recipeSequence)
        
        do {
            let result = try viewContext.fetch(fetchRequest)
            result.forEach { favoriteRecipe in
                viewContext.delete(favoriteRecipe)
            }
            try viewContext.save()
            return .success(true)
        } catch {
            return .failure(.removeFailed(error.localizedDescription))
        }
    }
    
    
}
