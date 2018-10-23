//
//  RecipeExtension.swift
//  RecipePuppyAPI_iOS22
//
//  Created by Ivan Ramirez on 10/22/18.
//  Copyright © 2018 ramcomw. All rights reserved.
//

import UIKit


extension RecipeListTableViewController {
    
    func updateUI() {
        updateBackground()
    }
    
    func  updateBackground() {
        let cuttingBoardImage = UIImage(named: "knifeCuttingBoard")
        let imageView = UIImageView(image: cuttingBoardImage)
        tableView.backgroundView = imageView
        imageView.contentMode = .scaleAspectFill
    }
    
}
