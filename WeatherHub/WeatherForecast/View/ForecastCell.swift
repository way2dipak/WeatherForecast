//
//  ForecastCell.swift
//  WeatherHub
//
//  Created by KAMLESH KUMAR on 22/03/18.
//  Copyright © 2018 kamlesh kumar. All rights reserved.
//

import UIKit

class WeatherForecastTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var visibilityLabel: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
    
        // Configure the view for the selected state
    }

}
