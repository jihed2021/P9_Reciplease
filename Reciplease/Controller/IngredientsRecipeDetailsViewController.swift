//
//  IngredientsRecipeDetailsViewController.swift
//  Reciplease
//
//  Created by Jihed Agrebaoui on 15/10/2021.
//

import UIKit

class IngredientsRecipeDetailsViewController: UIViewController {

    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeTitle: UILabel!
    @IBOutlet weak var ingredientListTextView: UITextView!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var favoriteButton: UIBarButtonItem!
    @IBOutlet weak var servingsLabel: UILabel!
    
    var isMyFavorite: Bool!
    var recipe: Recipe?
   
    override func viewWillAppear(_ animated: Bool) {
        configureRecipe()
    }
    
    @IBAction func getDirections(_ sender: Any) {
        guard let url = recipe?.url else {return}
        getRecipeDirection(urlString: url)
    }
    
    @IBAction func addRecipeToFavorite(_ sender: UIBarButtonItem) {
       saveRecipe()
    }
    
    fileprivate func configureRecipe() {
        favoriteButtonSetup()
        guard let recipe = recipe else {return}
        recipeImage.load(urlImageString: recipe.image)
        ingredientListTextView.text = recipe.ingredientLines.joined(separator: "\n - ")
        recipeTitle.text = recipe.label
        time.text = String (recipe.totalTime)
    }
    
    private func favoriteButtonSetup() {
        if let url = recipe?.url, RecipeEntity.checkIfFavoriteRecipe(with: url) {
            favoriteButton.tintColor = UIColor.green
        } else {
            favoriteButton.tintColor = UIColor.white
        }
    }

    func getRecipeDirection(urlString: String) {
        guard let url = URL(string: urlString) else {return}
        guard UIApplication.shared.canOpenURL(url) else {return}
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    private func saveRecipe() {
        if let url = recipe?.url, let recipe = recipe {
            if RecipeEntity.checkIfFavoriteRecipe(with:url) {
                RecipeEntity.deleteRecipeFromFavorite(with: url)
                favoriteButton.tintColor = UIColor.white
            } else {
                RecipeEntity.addRecipeToFavorite(recipe: recipe)
                favoriteButton.tintColor = UIColor.green
            }
        }
}
}
extension IngredientsRecipeDetailsViewController {
    func deleteRecipeFavorite(url: String?, barButtonItem: UIBarButtonItem) {
        RecipeEntity.deleteRecipeFromFavorite(with: url!)
        setupBarButtonItem(color: .white, barButtonItem: barButtonItem)

    }
    
    /// Manage the button of favorites
    func setupBarButtonItem(color: UIColor, barButtonItem: UIBarButtonItem) {
        barButtonItem.tintColor = color
        navigationItem.rightBarButtonItem = barButtonItem
    }
}
