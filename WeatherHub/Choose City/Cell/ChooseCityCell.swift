//
//  ChooseCityCell.swift
//  WeatherHub
//
//  Created by KAMLESH KUMAR on 22/03/18.
//  Copyright © 2018 kamlesh kumar. All rights reserved.
//

import UIKit

class ChooseCityCell: UITableViewCell {
    
    
    @IBOutlet weak var city_name: UILabel!
    @IBOutlet weak var city_img: UIImageView!
    @IBOutlet weak var line: UIView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
