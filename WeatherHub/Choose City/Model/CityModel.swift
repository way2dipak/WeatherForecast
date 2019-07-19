//
//  CityModel.swift
//  WeatherHub
//
//  Created by admin on 19/07/19.
//  Copyright © 2019 kamlesh kumar. All rights reserved.
//

import Foundation
import UIKit

struct CityModel {
    var cityName: String?
    var cityImage: UIImage
    
    init(cityName: String, cityImage: UIImage) {
        self.cityName = cityName 
        self.cityImage = cityImage
    }
}
