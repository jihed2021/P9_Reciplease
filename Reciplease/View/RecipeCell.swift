//
//  RecetteCell.swift
//  Reciplease
//
//  Created by Jihed Agrebaoui on 11/10/2021.
//

import Foundation
import UIKit

class RecipeCell: UITableViewCell {

    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var titleRecipeLabel: UILabel!
    @IBOutlet weak var detailsIngredientsLabel: UILabel!
    @IBOutlet weak var totalTimeLabel: UILabel!
    
    
    var recipe: Recipe? {
        didSet {
            titleRecipeLabel.text = recipe?.label
            detailsIngredientsLabel.text = recipe?.ingredientLines.joined(separator: ", ")
            totalTimeLabel.text = String(describing: recipe!.totalTime)
            recipeImageView.load(urlImageString: recipe?.image)
        }
    }
}




