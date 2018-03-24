//
//  ForecastCell.swift
//  WeatherHub
//
//  Created by KAMLESH KUMAR on 22/03/18.
//  Copyright © 2018 kamlesh kumar. All rights reserved.
//

import UIKit

class ForecastCell: UITableViewCell {
    
    
    @IBOutlet weak var date_lbl: UILabel!
    @IBOutlet weak var minTemp: UILabel!
    @IBOutlet weak var maxTemp: UILabel!
    @IBOutlet weak var humidity: UILabel!
    @IBOutlet weak var pressure: UILabel!
    @IBOutlet weak var wind: UILabel!
    @IBOutlet weak var visibility: UILabel!
    @IBOutlet weak var weather_icon: UIImageView!
    
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
