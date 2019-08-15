//
//  WeatherModel.swift
//  Demo2
//
//  Created by Vasile Morari on 8/15/19.
//  Copyright © 2019 Vasile Morari. All rights reserved.
//

import Foundation

struct WeatherModel: Codable {
    var daily: Daily
    
    struct Daily: Codable {
        var summary: String
    }
}
