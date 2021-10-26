//
//  RecetteCell.swift
//  Reciplease
//
//  Created by Jihed Agrebaoui on 11/10/2021.
//

import Foundation
import UIKit

class RecipeCell: UITableViewCell {

    @IBOutlet private weak var recipeImageView: UIImageView!
    @IBOutlet private weak var titleRecipeLabel: UILabel!
    @IBOutlet private weak var ingredientsLabel: UILabel!
    @IBOutlet private weak var totalTimeLabel: UILabel!

    
    var recipe: Recipe? {
        didSet {
            titleRecipeLabel.text = recipe?.label
            ingredientsLabel.text = recipe?.ingredientLines.joined(separator: ", ")
            totalTimeLabel.text = String(describing: recipe?.totalTime)
            recipeImageView.load(urlImageString: recipe?.image)
        }
    }
}




