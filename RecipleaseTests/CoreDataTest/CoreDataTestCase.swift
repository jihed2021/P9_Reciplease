//
//  CoreDataTestCase.swift
//  RecipleaseTests
//
//  Created by Jihed Agrebaoui on 21/10/2021.
//

import XCTest
import CoreData
@testable import Reciplease

class CoreDataTestCase: XCTestCase {

   private let fakeRecipe = Recipe(label: "pizza", image: "https://www.openclassrooms.com", ingredientLines: ["cheese","pizza legs"], url: "fakeUrl", totalTime: 20, yield: 3)
   
    func testGivenRecipe_WhenAddToFaorite_ThenRecipeIsAddedToFavorite() {
        RecipeEntity.addRecipeToFavorite(recipe: fakeRecipe)
        XCTAssertTrue(RecipeEntity.checkIfFavoriteRecipe(with: "fakeUrl"))
    }
    
    func testGivenFavoriteRecipe_WhenRemoveFromFavorite_ThenRecipeRemoved() {
        RecipeEntity.addRecipeToFavorite(recipe: fakeRecipe)
        XCTAssertTrue(RecipeEntity.checkIfFavoriteRecipe(with: "fakeUrl"))
        RecipeEntity.deleteRecipeFromFavorite(with: "fakeUrl")
        XCTAssertFalse(RecipeEntity.checkIfFavoriteRecipe(with: "fakeUrl"))
    }
    func testGivenRecipe_WhenAddToAll_ThenAllUpdated() {
        RecipeEntity.addRecipeToFavorite(recipe: fakeRecipe)
        XCTAssertFalse(RecipeEntity.all().isEmpty)
    }
}
