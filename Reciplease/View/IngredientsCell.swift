//
//  IngredientsCell.swift
//  Reciplease
//
//  Created by Jihed Agrebaoui on 15/10/2021.
//

import Foundation
import UIKit

class IngredientCell: UITableViewCell {
    
    
    @IBOutlet weak var ingredientLabel: UILabel!
    
    func updateIngredientLabel(ingredient: String)  {
        ingredientLabel.text = "- " + ingredient
    }
}
