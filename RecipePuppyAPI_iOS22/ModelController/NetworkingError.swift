//
//  NetworkingError.swift
//  RecipePuppyAPI_iOS22
//
//  Created by Ivan Ramirez on 10/22/18.
//  Copyright © 2018 ramcomw. All rights reserved.
//

import Foundation

enum NetworkingError: Error {
    case badBaseURL(String)
    case forwardedError(Error)
    case invalidData(String)
    case badBuiltURL(String)
}
