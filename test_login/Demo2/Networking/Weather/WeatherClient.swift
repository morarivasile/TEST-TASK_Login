//
//  WeatherClient.swift
//  Demo2
//
//  Created by Vasile Morari on 8/15/19.
//  Copyright © 2019 Vasile Morari. All rights reserved.
//

import Foundation

class WeatherClient: APIClient {
    let session: URLSession
    
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        self.init(configuration: .default)
    }
    
    func getData<T: Decodable>(with endpoint: WeatherData, completion: @escaping (Result<T, APIError>) -> Void) {
        guard let request = endpoint.request else {
            assertionFailure("Failed to create URL Request")
            return
        }
        fetch(with: request, decode: { json -> T? in
            guard let banners = json as? T else { return  nil }
            return banners
        }, completion: completion)
    }
}
