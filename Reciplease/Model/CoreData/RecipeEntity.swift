//
//  CoreData.swift
//  Reciplease
//
//  Created by Jihed Agrebaoui on 17/10/2021.
//


import CoreData

class RecipeEntity: NSManagedObject {

    static func all() -> [Recipe] {
        let request: NSFetchRequest<RecipeEntity> = RecipeEntity.fetchRequest()
        guard let favoriteRecipes = try? AppDelegate.viewContext.fetch(request) else {
            return []
        }
        var recipes = [Recipe]()
        for favorite in favoriteRecipes {
            if let label = favorite.label,
               let image = favorite.image,
               let url = favorite.url,
               let ingredientLines = favorite.ingredientLines {
                let recipe = Recipe(label:label, image: image, ingredientLines: (ingredientLines.split(separator: ",").map {String($0)}), url: url, totalTime: favorite.totalTime, yield: favorite.yield)
                recipes.append(recipe)
            }
        }
        return recipes
    }
    
    
    //MARK: - Add recipe to Core Data
    
    static func addRecipeToFavorite(recipe:Recipe) {
        let favoriteRecipe = RecipeEntity(context: AppDelegate.viewContext)
        updateRecipe(favoriteRecipe, recipe)
        do {
            try AppDelegate.viewContext.save()
        } catch {
            fatalError("Error to save Recip: \(error)")
        }
    }
    
    private static func updateRecipe(_ favoriteRecipe: RecipeEntity, _ recipe: Recipe) {
        favoriteRecipe.label = recipe.label
        favoriteRecipe.totalTime = recipe.totalTime
        favoriteRecipe.yield = recipe.yield
        favoriteRecipe.ingredientLines = recipe.ingredientLines.joined(separator: ",")
        favoriteRecipe.url = recipe.url
        favoriteRecipe.image = recipe.image
    }
    
    //MARK: - check if recipe exist in Core Data
    static func checkIfFavoriteRecipe(with url: String) -> Bool {
        let request: NSFetchRequest<RecipeEntity> = RecipeEntity.fetchRequest()
        request.predicate = NSPredicate(format: "url == %@", url)
        guard let count = try? AppDelegate.viewContext.count(for: request) else {
            return false
        }
        return count == 0 ? false : true
    }
    
    //MARK: - Delete recipe from Core Data
    
    static func deleteRecipeFromFavorite (with url: String) {
        let request: NSFetchRequest<RecipeEntity> = RecipeEntity.fetchRequest()
        request.predicate = NSPredicate(format: "url == %@", url)
        if let favoriteRecipes = try? AppDelegate.viewContext.fetch(request) {
            for recipe in favoriteRecipes {
                AppDelegate.viewContext.delete(recipe)
            }
        }
        do {
            try AppDelegate.viewContext.save()
        } catch {
            fatalError("Error to save Recip: \(error)")
        }
    }
 
}
