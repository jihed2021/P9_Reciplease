//
//  RecipeViewController.swift
//  Reciplease
//
//  Created by Jihed Agrebaoui on 13/10/2021.
//

import UIKit

class RecipeViewController: UIViewController {
    
    var isFavorite: Bool = true
    var listRecipes = [Recipe]()
    @IBOutlet weak var recipeListtableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if isFavorite {
            listRecipes = RecipeEntity.all()
        }
        recipeListtableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "ListRecipesCell", bundle: nil)
        recipeListtableView.register(nib, forCellReuseIdentifier: "recipeCellIdentifier")
        recipeListtableView.reloadData()
    }
}


extension RecipeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listRecipes.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "recipeCellIdentifier", for: indexPath) as? RecipeCell else {
            return UITableViewCell()
        }
        cell.recipe = listRecipes[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "ingredientsRecipe") as? IngredientsRecipeDetailsViewController {
            vc.recipe = listRecipes[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}


