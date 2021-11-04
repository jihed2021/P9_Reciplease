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
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let textView = UITextView()
        textView.text = "Enregister you favorite recipe please \n ❗️... you can add recipes to your favorites by clicking on the button 💚 at the top right of your recipe detail"
        textView.textColor = .orange
        textView.textAlignment = .center
        textView.font = .systemFont(ofSize: 24)
        textView.backgroundColor = .darkGray
        return textView
    }
   
    
     
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if RecipeEntity.all().isEmpty {
            return 150
        }
        return 0
    }
}


