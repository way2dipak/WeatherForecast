//
//  ChooseCityViewController.swift
//  WeatherHub
//
//  Created by DIPAK KUMAR on 22/03/18.
//  Copyright © 2018 Dipak Kumar. All rights reserved.
//

import UIKit

class ChooseCityViewController: UIViewController {
    
    @IBOutlet weak var cityTableView: UITableView!
    
    var dataSource: [CityModel] = [] {
        didSet {
            DispatchQueue.main.async {
                self.cityTableView.reloadData()
            }
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpDatasource()
    }
    
    //MARK:- SETTING UP DATASOURCE
    func setUpDatasource() {
        dataSource.append(CityModel(cityName: "Bangalore", cityImage: #imageLiteral(resourceName: "bangalore")))
        dataSource.append(CityModel(cityName: "Chennai", cityImage: #imageLiteral(resourceName: "chennai")))
        dataSource.append(CityModel(cityName: "Delhi", cityImage: #imageLiteral(resourceName: "delhi")))
        dataSource.append(CityModel(cityName: "Kolkata", cityImage: #imageLiteral(resourceName: "kolkata")))
        dataSource.append(CityModel(cityName: "Mumbai", cityImage: #imageLiteral(resourceName: "mumbai")))
    }
    
    //MARK:- NAVIGATE TO FORECAST VC
    func navigateToForecastVC(name: String) {
        let vc = storyboard?.instantiateViewController(withIdentifier: WeatherForecastViewController.identifier) as! WeatherForecastViewController
        vc.cityName = name
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension ChooseCityViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataSource.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ChooseCityTableViewCell.identifier) as! ChooseCityTableViewCell
        
        let details = dataSource[indexPath.row]
        
        cell.cityNameLabel.text  = details.cityName ?? "NA"
        cell.cityImageView.image = details.cityImage
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (dataSource[indexPath.row].cityName != "") {
            navigateToForecastVC(name: dataSource[indexPath.row].cityName ?? "NA")
        }
        else {
            print("CityName is Empty 🙊")
        }
    }
}
    
