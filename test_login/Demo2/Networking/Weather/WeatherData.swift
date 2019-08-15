//
//  WeatherData.swift
//  Demo2
//
//  Created by Vasile Morari on 8/15/19.
//  Copyright © 2019 Vasile Morari. All rights reserved.
//

import Foundation

enum WeatherData {
    case forecast(latitude: Double, longitude: Double)
}

extension WeatherData: Endpoint {
    var host: String {
        return "https://api.darksky.net"
    }
    
    var basePath: String {
        return "/forecast"
    }
    
    var key: String {
        return "/406941fd774a0639f7e11569154711d5"
    }
    
    var path: String {
        switch self {
        case .forecast(let latitude, let longitude):
            return "/\(latitude),\(longitude)"
        }
    }
}
