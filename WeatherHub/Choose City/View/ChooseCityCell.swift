//
//  ChooseCityCell.swift
//  WeatherHub
//
//  Created by DIPAK KUMAR on 22/03/18.
//  Copyright © 2018 Dipak kumar. All rights reserved.
//

import UIKit

class ChooseCityTableViewCell: UITableViewCell {
    
    static let identifier = "ChooseCityCell"
    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var cityImageView: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        cityImageView.layer.cornerRadius = cityImageView.frame.height/2
        cityImageView.clipsToBounds = true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
