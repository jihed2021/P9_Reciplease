//
//  IngerdientsViewController.swift
//  Reciplease
//
//  Created by Jihed Agrebaoui on 10/10/2021.
//

import UIKit

class IngredientsViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var ingredientstableView: UITableView!
    
    @IBOutlet weak var addButton: UIButton!
    var ingredients: [String] = []
    private var recipeList = [Recipe]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.layer.cornerRadius = 8
        addButton.layer.cornerRadius = 8
        ingredientstableView.reloadData()

    }

    @IBAction func addIngredient(_ sender: UIButton) {

        guard let newIngrediant = textField.text else {
            return presentAlert(message: "Wrong")
        }
        ingredients.append(newIngrediant)
        ingredientstableView.reloadData()
        textField.text = ""
    }
    
    @IBAction func clearTableView(_ sender: Any) {
        ingredients.removeAll()
        ingredientstableView.reloadData()
    
    }
    @IBAction func showRecettes(_ sender: UIButton) {
        getListRecipe()
    }
    func getListRecipe() {
        guard !ingredients.isEmpty else {
            presentAlert(message: "List of ingredient is Empty")
            return
        }
        RecipeService.shared.getRecipe(ingredients: ingredients) { success, recipes in
            if success, let recipes = recipes {
                self.recipeList = recipes
                self.performSegue(withIdentifier: "showRecipes", sender: self)
            }
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? RecipeViewController {
            destination.listRecipes = recipeList
            destination.isFavorite = false
        }
    }
}
extension IngredientsViewController: UITableViewDataSource, UITableViewDelegate {
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let ingredientCell = tableView.dequeueReusableCell(withIdentifier: "ingredientsCell", for: indexPath) as? IngredientCell else {
            return UITableViewCell()
        }

        let ingredient = ingredients[indexPath.row]
        ingredientCell.updateIngredientLabel(ingredient: ingredient)
        return ingredientCell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredients.count
    }
}

extension IngredientsViewController {
    private func presentAlert(message: String) {
        let alertVC = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
}
   
