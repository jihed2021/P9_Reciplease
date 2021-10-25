//
//  EdamamSessionFake.swift
//  RecipleaseTests
//
//  Created by Jihed Agrebaoui on 24/10/2021.
//
import Foundation
import Alamofire
@testable import Reciplease

class EdamamSessionFake: EdamamProtocol {

    private let fakeResponse: FakeResponse

    init(fakeResponse: FakeResponse) {
        self.fakeResponse = fakeResponse
    }
 
    func request(url: URL, completionHandler: @escaping (AFDataResponse<Any>) -> Void) {
        let httpResponse = fakeResponse.response
        let data = fakeResponse.data
        let error = fakeResponse.error
        let urlRequest = URLRequest(url: URL(string: "https://www.openClassroom.fr")!)
        let result: Result<Any, AFError> = .success("OK")
        let metrics: URLSessionTaskMetrics? = nil
        let serializationDuration: TimeInterval = 0
        
        completionHandler(AFDataResponse(request: urlRequest, response: httpResponse, data: data, metrics: metrics, serializationDuration: serializationDuration, result: result))
    }
}
