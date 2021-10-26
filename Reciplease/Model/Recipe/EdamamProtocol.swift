//
//  EdamamProtocol.swift
//  Reciplease
//
//  Created by Jihed Agrebaoui on 22/10/2021.
//

import Foundation
import Alamofire

protocol EdamamProtocol {
    func request(url: URL, completionHandler: @escaping (AFDataResponse<Any>) -> Void)
}
