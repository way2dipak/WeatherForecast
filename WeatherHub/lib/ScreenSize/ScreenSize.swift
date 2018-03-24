//
//  ScreenSize.swift
//  WeatherHub
//
//  Created by KAMLESH KUMAR on 24/03/18.
//  Copyright © 2018 kamlesh kumar. All rights reserved.
//

import UIKit

class ScreenSize: NSObject {
    var ScreenHeight = Int()
    func screen_height()->Int
    {
        var screensize = UIScreen.main.bounds
        ScreenHeight = Int(screensize.height)
        
        return ScreenHeight
    }
    
    
}


