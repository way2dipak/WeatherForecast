//
//  WeatherForecastViewController.swift
//  WeatherHub
//
//  Created by admin on 19/07/19.
//  Copyright © 2019 kamlesh kumar. All rights reserved.
//

import UIKit
import SDWebImage
import SwiftyGif

class WeatherForecastViewController: UIViewController {
    
    static let identifier = "WeatherForecastViewController"
    
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var weatherTypeLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var todayWeatherTypeLabel: UILabel!
    @IBOutlet weak var tomorrowWeatherTypeLabel: UILabel!
    @IBOutlet weak var todayTempLabel: UILabel!
    @IBOutlet weak var tomorrowTempLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var tempFeelLabel: UILabel!
    @IBOutlet weak var UVIndexLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    
    @IBOutlet weak var todayWeatherIcon: UIImageView!
    @IBOutlet weak var tomorrowWeatherIcon: UIImageView!

    @IBOutlet weak var detailsView1: UIView!
    @IBOutlet weak var detailsView2: UIView!
    
    @IBOutlet weak var scroll: UIScrollView!
    @IBOutlet weak var backgroundView: UIView!
    
    
    var date = Date()
    var dateFormatter = DateFormatter()
    
    var cityName = ""
    
    
    let forecastModel = ForeCastModel()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        scroll.alpha = 0.0
        backgroundView.alpha = 0.0
        self.title = cityName
        setUpDetailsView()
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadWeather()
    }
    
    //MARK:- SETUP DETAILS VIEW
    func setUpDetailsView() {
        detailsView1.layer.cornerRadius = 10
        detailsView1.clipsToBounds = true
        detailsView2.layer.cornerRadius = 10
        detailsView2.clipsToBounds = true
    }
    
    //MARK:- DISPLAY VIEW
    func displayView() {
        UIView.animate(withDuration: 0.3) {
            self.scroll.alpha = 1.0
            self.backgroundView.alpha = 1.0
        }
    }
    
    //MARK:- LOAD WEATHER API
    func loadWeather() {
        LoaderManager.shared.showLoader()
        let link = "\(Constant.shared.baseUrl)data/2.5/forecast?q=\(cityName)&units=metric&cnt=16&lang=en&appid=\(Constant.shared.appId)"
        
        forecastModel.getWeatherDetails(link: link) { (result) in
            switch result {
            case .failure(let error):
                LoaderManager.shared.hideLoader()
                AlertManager.shared.displayAlert(vc: self, title: "Alert", message: error.localizedDescription)
            case .success(let response) :
                if response.count != 0 {
                    DispatchQueue.main.async {
                        self.updateUI(datasource: response)
                    }
                }
                else {
                    AlertManager.shared.displayAlert(vc: self, title: "Alert", message: "Server Busy")
                }
                LoaderManager.shared.hideLoader()
            }
        }
    }
    
    //MARK:- CONVERT UNIXDATE TO STRING
    /*
    func convertUnixDateToString(unixDate: Int) -> String {
        let value = Date(timeIntervalSince1970: TimeInterval(exactly: unixDate)!)
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.string(from: value)
    }
 */
    
    //MARK:- UPDATE UI
    func updateUI(datasource: [List]) {
        if datasource[0].weather[0].main == .clouds {
            coverImageView.setGifImage(UIImage(gifName: "cloudy"))
        }
        else if datasource[0].weather[0].main == .clear  {
            coverImageView.image = #imageLiteral(resourceName: "clear")
        }
        else if datasource[0].weather[0].main == .rain {
            coverImageView.setGifImage(UIImage(gifName: "rain"))
        }
        weatherTypeLabel.text = datasource[0].weather[0].weatherDescription.capitalized
        temperatureLabel.text = "\(Int(datasource[0].main.temp))°"
        todayWeatherTypeLabel.text = "Today - \(datasource[0].weather[0].weatherDescription)"
        let link1 = URL(string: "\(Constant.shared.imageBaseUrl)\(datasource[0].weather[0].icon).png")
        todayWeatherIcon.sd_setImage(with: link1, completed: nil)
        todayTempLabel.text = "\(Int(datasource[0].main.tempMax)) / \(Int(datasource[0].main.tempMin))°C"
        //---------------------------------------------------------------------------------//
        tomorrowWeatherTypeLabel.text = "Tomorrow - \(datasource[1].weather[0].weatherDescription)"
        let link2 = URL(string: "\(Constant.shared.imageBaseUrl)\(datasource[1].weather[0].icon).png")
        tomorrowWeatherIcon.sd_setImage(with: link2, completed: nil)
        tomorrowTempLabel.text = "\(Int(datasource[1].main.tempMax)) / \(Int(datasource[1].main.tempMin))°C"
        
        speedLabel.text = "\(datasource[0].wind.speed)km/h"
        tempFeelLabel.text = "\(datasource[0].main.humidity)"
        pressureLabel.text = "\(datasource[0].main.pressure) mb"
        displayView()
        
    }
    

}

