//
//  RecipeListTableViewController.swift
//  RecipePuppyAPI_iOS22
//
//  Created by Ivan Ramirez on 10/22/18.
//  Copyright © 2018 ramcomw. All rights reserved.
//

import UIKit
import AVFoundation


class RecipeListTableViewController: UITableViewController  {
    
    // Funte de Verdad
    var recipes: [Recipe] = []
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var activityView: UIView!
    @IBOutlet weak var recipeSearchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recipeSearchBar.delegate = self
        self.activityView.isHidden = true
        updateUI()
        //
        guard let searchText = recipeSearchBar.text else {return}
        RecipeController.fetchRecipe(with: searchText) { (recipes, error) in
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Table view data source
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return recipes.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath) as? RecipeTableViewCell else {return UITableViewCell()}
        
        let recipe = recipes[indexPath.row]
        cell.recipe = recipe
    
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
   override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor(white: 0, alpha: 0)
    }
    
    // MARK: - Navigation toDetailVC
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
    
}

extension RecipeListTableViewController: UISearchBarDelegate {
     func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
          guard let searchText = searchBar.text, !searchText.isEmpty
            else {
        
             AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            return
        }
        
        
        recipeSearchBar.resignFirstResponder()
        
        //Mark: - Activity Indicator
        activityView.backgroundColor = UIColor.clear
        activityIndicator.color = UIColor(red: 0.3, green: 165/255, blue: 0.09, alpha: 1)
        activityIndicator.startAnimating()
        activityView.isHidden = false
        
        //MARK: - Search Text
        
        RecipeController.fetchRecipe(with: searchText) { (recipes, error) in
            guard let recipes = recipes else { return }
            print(recipes.count)
            
            self.recipes = recipes
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.recipeSearchBar.text = ""
                
                // Mark: - Activity Indicator
                self.activityView.isHidden = true
                self.activityIndicator.stopAnimating()
            }
        }
    }
}


