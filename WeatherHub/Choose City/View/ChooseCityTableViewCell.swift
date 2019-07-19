//
//  ChooseCityTableViewCell.swift
//  WeatherHub
//
//  Created by admin on 19/07/19.
//  Copyright © 2019 kamlesh kumar. All rights reserved.
//

import UIKit

class ChooseCityTableViewCell: UITableViewCell {
    
    static let identifier = "ChooseCityTableViewCell"
    
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
