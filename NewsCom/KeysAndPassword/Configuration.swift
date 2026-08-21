//
//  Configuration.swift
//  NewsCom
//
//  Created by ANJALI SHARMA R on 25/05/26.
//

import Foundation

struct Configuration {
    
    static var apiKey: String {
        
        guard let apiKey = Bundle.main.path(forResource: "Secrets", ofType: "plist")), let object = NSDictionary(contentsOfFile: apiKey), let apiKeyValue = object["API_KEY"], let apiKey = apiKeyValue as? String
        else {
            fatalError("API_KEY not found in Info.plist")
        }
        return apiKey
    }
}
