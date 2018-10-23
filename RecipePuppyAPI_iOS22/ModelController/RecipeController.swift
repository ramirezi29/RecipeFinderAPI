//
//  RecipeController.swift
//  RecipePuppyAPI_iOS22
//
//  Created by Ivan Ramirez on 10/22/18.
//  Copyright © 2018 ramcomw. All rights reserved.
//

import UIKit

class RecipeController {
    
    //expectations with two quires
    //http://www.recipepuppy.com/api/?i=bacon,bread&q=bacon
    
    //reality
    //http://www.recipepuppy.com/
    //  http://www.recipepuppy.com/api
    // http://www.recipepuppy.com/api?i=Cheese,bread
    
    
    static let baseURL = URL(string: "http://www.recipepuppy.com")
    
    
    private init() {}
    
    typealias FetchRecipeCompletion = ([Recipe]?, NetworkingError?) -> Void
    
    
    // NOTE: - Funte De Verdad ???
    static func fetchRecipe(with SearchText: String, completion: @escaping FetchRecipeCompletion) {
        
        
        guard let unwrappedURL = baseURL else {
            completion(nil, .badBaseURL("\n\nfix base ulr\n\n"))
            fatalError("\n\nBad Base URL Do Not Continue\n\n")
        }
        
        let url = unwrappedURL.appendingPathComponent("api")
        print(url.absoluteURL)
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        
        let multipleEntrySearchTermItemQuery = URLQueryItem(name: "i", value: SearchText)
//         let singleSearchTermItemQuery = URLQueryItem(name: "q", value: SearchText)
        
      //  components?.queryItems = [multipleEntrySearchTermItemQuery, singleSearchTermItemQuery]
      components?.queryItems = [multipleEntrySearchTermItemQuery]
        
        print(components?.url ?? "\n\nThere's an issue with the URL, could be emtpy \n\n")
        
        guard let builtURL = components?.url else { completion([], .badBuiltURL("There is an error with the Built URL"))
            return
        }
        
        URLSession.shared.dataTask(with: builtURL) { (data, _, error) in
            if let error = error {
                print("\n\n🚀 There was an error with dataTask in: \(#file) \n\n \(#function); \n\n\(error); \n\n\(error.localizedDescription) 🚀\n\n")
                completion(nil, .forwardedError(error)); return
            }
            guard let data = data else {
                completion(nil, .invalidData("\n\nInvalid Data\n\n")); return
            }
            
            do {
                let topLevelObject = try JSONDecoder().decode(TopLevelObject.self, from: data)
                let recipesThatCameBackFromTheWeb = topLevelObject.results
                completion(recipesThatCameBackFromTheWeb, nil)
                
            } catch let error {
                print("\n\n🚀 There was an error with with JSONDecoder in: \(#file) \n\n \(#function); \n\n\(error); \n\n\(error.localizedDescription) 🚀\n\n")
                completion(nil, .forwardedError(error)); return
            }
            }.resume()
    }
}

// MARK: - Fetch Image
extension RecipeController {
    
    typealias FetchImageCompletion = ((UIImage?), NetworkingError?) -> Void
    
    static func fetchImageFromTheWeb(with thumbnail: String, completion: @escaping FetchImageCompletion) {
        
        guard let urlForImage = URL(string: thumbnail) else {
            completion(nil, .badBaseURL("\n\nfix base ulr\n\n"))
            fatalError("\n\nBad Base URL Do Not Continue\n\n")
        }
        print(urlForImage.absoluteURL)
        
        URLSession.shared.dataTask(with: urlForImage) { (data, _, error) in
            if let error = error {
                print("\n\n🚀 There was an error with dataTask in: \(#file) \n\n \(#function); \n\n\(error); \n\n\(error.localizedDescription) 🚀\n\n")
                completion(nil, .forwardedError(error)); return
            }
            guard let data = data else {
                completion(nil, .invalidData("\nInvalid Data\n"));return
            }
            let image = UIImage(data: data)
            completion(image, nil)
        }.resume()
    }
}






