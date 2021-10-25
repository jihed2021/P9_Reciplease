//
//  FakeResponseData.swift
//  RecipleaseTests
//
//  Created by Jihed Agrebaoui on 21/10/2021.
//

import Foundation
import Alamofire
class FakeResponseData {
    
   static let responseOK = HTTPURLResponse(url: URL(string: "https://openclassrooms.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
   static let responseKO = HTTPURLResponse(url: URL(string: "https://openclassrooms.com")!, statusCode: 400, httpVersion: nil, headerFields: nil)!
    
    class RecipeError: Error {}
    
    static let error = RecipeError()

   static var quoteCorrectData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
       let url = bundle.url(forResource: "EdamamResponse", withExtension: "json")
       
       let data = try! Data(contentsOf: (url!))
        return data
    }
    
    static let quoteIncorrectData = "erreur".data(using: .utf8)
}
