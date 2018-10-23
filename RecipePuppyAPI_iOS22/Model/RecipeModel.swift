//
//  RecipeModel.swift
//  RecipePuppyAPI_iOS22
//
//  Created by Ivan Ramirez on 10/22/18.
//  Copyright © 2018 ramcomw. All rights reserved.
//

import Foundation

struct TopLevelObject: Decodable {
    
    let results: [Recipe]
}

struct Recipe: Decodable {
    
    var title: String
    var ingredients: String
    var thumbnail: String
}
