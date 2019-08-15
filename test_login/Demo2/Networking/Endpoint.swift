//
//  Endpoint.swift
//  Demo2
//
//  Created by Vasile Morari on 8/15/19.
//  Copyright © 2019 Vasile Morari. All rights reserved.
//

import Foundation

protocol Endpoint {
    var host: String { get }
    var basePath: String { get }
    var key: String { get }
    var path: String { get }
}

extension Endpoint {
    var baseURLComponents: URLComponents? {
        guard var components = URLComponents(string: host) else {
            assertionFailure("Invalid HOST string: \(host)")
            return nil
        }
        components.path = basePath
        return components
    }
    
    var request: URLRequest? {
        guard let url = baseURLComponents?.url?
            .appendingPathComponent(key)
            .appendingPathComponent(path) else {
            assertionFailure("Unable to get URL from provided base URL components!")
            return nil
        }
        return URLRequest(url: url)
    }
}
