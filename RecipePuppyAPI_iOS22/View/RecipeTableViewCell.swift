//
//  RecipeTableViewCell.swift
//  RecipePuppyAPI_iOS22
//
//  Created by Ivan Ramirez on 10/22/18.
//  Copyright © 2018 ramcomw. All rights reserved.
//

import UIKit

class RecipeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var ingredientsLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // MARK: - Landing Pad
    var recipe: Recipe? {
        didSet {
            self.updateViews()
            print("pizza🍕")
        }
    }
    
    func updateViews() {
        guard let recipe = recipe else {return}
        self.nameLabel.text = recipe.title
        self.ingredientsLabel.text = recipe.ingredients
        
//        DispatchQueue.main.async {
        
            RecipeController.fetchImageFromTheWeb(with: recipe.thumbnail, completion: { (image, error) in
                guard let image = image else {return}
                DispatchQueue.main.async {
                    self.recipeImageView.image = image
                }
            })
//        }
    }
}
