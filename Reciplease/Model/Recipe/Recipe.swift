//
//  Recipe.swift
//  Reciplease
//
//  Created by Jihed Agrebaoui on 13/10/2021.
//

import Foundation

struct RecipeSearch: Codable {
    let hits: [Hit]
}

struct Hit: Codable {
    let recipe: Recipe
}
struct Recipe: Codable {
    let label: String
    let image: String
    let ingredientLines: [String]
    let url: String
    let totalTime: Float
    let yield: Float
}
