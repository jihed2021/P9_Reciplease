//
//  EdamamSession.swift
//  Reciplease
//
//  Created by Jihed Agrebaoui on 22/10/2021.
//

import Foundation
import Alamofire
class EdamamSession: EdamamProtocol {
  
    func request(url: URL, completionHandler: @escaping (AFDataResponse<Any>) -> Void) {
        AF.request(url).responseJSON { response in
            completionHandler(response)
        }
    }
    
}
