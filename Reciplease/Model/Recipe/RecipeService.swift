//
//  RecipeService.swift
//  Reciplease
//
//  Created by Jihed Agrebaoui on 13/10/2021.
//

import Foundation
import Alamofire

class RecipeService {
    
    static let shared = RecipeService()
    init(edamamSession: EdamamProtocol = EdamamSession()) {
        self.edamamSession = edamamSession
    }
    private let edamamSession: EdamamProtocol
    
    func getRecipe(ingredients: [String], callback:@escaping (Bool, [Recipe]?) -> Void) {
        let url = createUrl(ingredientsList: ingredients)
        edamamSession.request(url: url) { (responseData) in
            switch responseData.result {
            case .success:
                guard let data = responseData.data else {
                    callback(false,nil)
                    return
                }
                guard let response = responseData.response, response.statusCode == 200 else {
                    callback(false,nil)
                    return
                }
                do {
                    let recipeSearch = try JSONDecoder().decode(RecipeSearch.self, from: data)
                    let recipes = recipeSearch.hits.map { hit in
                        hit.recipe
                    }
                    callback(true, recipes)
                } catch {
                    callback(false, nil)
                    return
                }
            case .failure :
                callback(false, nil)
            }
            
        }
    }
    
    private func createUrl(ingredientsList: [String]) -> URL {
        let ingredientsList = ingredientsList.joined(separator: ",")
        let baseUrl = "https://api.edamam.com/search?app_id=dde4f9aa&app_key=f3f24f5f01fae440a69856f3287aa43d&to=50&q="
        let urlForRecipes = URL(string: baseUrl + ingredientsList)
        return urlForRecipes!
    }
    
}
