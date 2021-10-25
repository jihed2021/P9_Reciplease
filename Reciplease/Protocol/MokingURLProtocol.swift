//
//  MokingURLProtocol.swift
//  Reciplease
//
//  Created by Jihed Agrebaoui on 22/10/2021.
//

import Foundation

public final class MockingURLProtocol: URLProtocol {

    public override class func canInit(with request: URLRequest) -> Bool {
        // Print valuable request information.
                print("? Running request: \(request.httpMethod ?? "") - \(request.url?.absoluteString ?? "")")

        // By returning `false`, this URLProtocol will do nothing less than logging.
                return false
    }
}
