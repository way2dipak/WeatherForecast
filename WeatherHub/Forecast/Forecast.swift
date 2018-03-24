//
//  Forecast.swift
//  WeatherHub
//
//  Created by KAMLESH KUMAR on 22/03/18.
//  Copyright © 2018 kamlesh kumar. All rights reserved.
//

import UIKit
import SwiftyGif

class Forecast: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    
    @IBOutlet weak var clouds_img: UIImageView!
    @IBOutlet weak var weather_table: UITableView!
    @IBOutlet weak var City_name: UILabel!
    @IBOutlet weak var temprature: UILabel!
    @IBOutlet weak var temp_description: UILabel!
    @IBOutlet weak var degree: UILabel!
    
    var weatherArray = NSMutableArray()
    var city = String()
    
    var date = Date()
    var dateFormatter = DateFormatter()
    
    var imgbaseurl = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        //setting the cityname
        
        imgbaseurl = "http://openweathermap.org/img/w/"
        
        weather_table.isHidden = true
        degree.isHidden = true
        
        City_name.text = city
        
        let gif = UIImage(gifName: "clouds.gif")
        clouds_img.setGifImage(gif)
        
        fetchWeather(city)
        
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
    }
    
    //alert func
    func AlertMsg(msg: String)
    {
        let alertview = UIAlertController.init(title: "Message", message: msg, preferredStyle: .alert)
//        let ok = UIAlertAction.init(title: "OK", style: .destructive, handler: nil)
        let retry  = UIAlertAction.init(title: "Retry", style: .destructive) { (handler) in
            
            self.fetchWeather(self.city)
        }
        alertview.addAction(retry)
        self.present(alertview, animated: true, completion: nil)
        
    }
    
    
    func fetchWeather(_ cityname : String)
    {
        
        SVProgressHUD.show(withStatus: "fetching weather details....")
        
        self.view.isUserInteractionEnabled = false
        
        
        //weather api app id
        let appID = "3ffe5b777806a0cbbe3d9474e7aff7d3"
        
        let link = "http://api.openweathermap.org/data/2.5/forecast?q=\(cityname)&units=metric&cnt=16&lang=en&appid=\(appID)"
        
        let url = URL.init(string: link)
        
        print("url = \(url)")
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            guard error == nil else{
                print("oops! might be some problem...!!")
                self.view.isUserInteractionEnabled = true
                self.AlertMsg(msg: "\(error!.localizedDescription)")
                SVProgressHUD.dismiss()
                return
            }
            //result
            var parseResult = NSDictionary()
            do{
                parseResult = try JSONSerialization.jsonObject(with: data!, options: []) as! NSDictionary
                print("parseResult = \(parseResult)")
                var list = NSArray()
                list = parseResult["list"] as! NSArray
                print("list = \(list[0])")
                
                if list.count>0
                {
                    
                    
                    for var i in 0..<list.count
                    {
                        self.weatherArray.add(list[i])
                    }
                    
                    print("weatherArray = \(self.weatherArray)")
                    
                    DispatchQueue.main.async(execute: {
                        self.view.isUserInteractionEnabled = true
                        self.weather_table.isHidden = false
                        self.degree.isHidden = false
                        
                        let temp_in_kelvin = ((self.weatherArray.value(forKey: "main") as! NSArray).value(forKey: "temp") as! NSArray).object(at: 0) as! NSNumber
                        
                        self.temprature.text = String(describing: Int(temp_in_kelvin))
                        
                        self.temp_description.text = String(describing: ((((self.weatherArray.value(forKey: "weather") as! NSArray).object(at: 0) as! NSArray).value(forKey: "main") as! NSArray)).object(at: 0) as! String)
                        
                        self.weather_table.reloadData()
                        
                    })
                    
                    SVProgressHUD.dismiss()
                }
                else
                {
                    self.AlertMsg(msg: "Server is busy!! Please try Again")
                }
                //                    self.webArray = (dict.value(forKey: "value") as? NSArray)!
                //                    print("webArray = \(self.webArray)")
                
                
            }catch{
                print("could not parse data as json = \(error)")
                self.view.isUserInteractionEnabled = true
                SVProgressHUD.dismiss()
            }
            }.resume()
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "forecastcell") as! ForecastCell
        
        //converting unixdatetime to human-readable time
        let unixdate = NSDate(timeIntervalSince1970: TimeInterval((self.weatherArray.value(forKey: "dt") as! NSArray).object(at: indexPath.row) as! NSNumber))
        
        cell.date_lbl.text = dateFormatter.string(from: unixdate as Date)
        /////////////////////////////////////////////////////////////////////
        let get_min = Double(((self.weatherArray.value(forKey: "main") as! NSArray).value(forKey: "temp_min") as! NSArray).object(at: indexPath.row) as! NSNumber)
        
        let convrt_min = Int(floor(get_min))
        
        cell.minTemp.text = String(convrt_min)
        /////////////////////////////////////////////////////////////////////
        
        let get_max = Double(((self.weatherArray.value(forKey: "main") as! NSArray).value(forKey: "temp_max") as! NSArray).object(at: indexPath.row) as! NSNumber)
        
        let convrt_max = Int(ceil(get_max))
        
        cell.maxTemp.text = String(convrt_max)
        
        /////////////////////////////////////////////////////////////////////
        
        
        cell.humidity.text = String(describing: ((self.weatherArray.value(forKey: "main") as! NSArray).value(forKey: "humidity") as! NSArray).object(at: indexPath.row) as! NSNumber)
        
        cell.pressure.text = "\(String(describing: ((self.weatherArray.value(forKey: "main") as! NSArray).value(forKey: "pressure") as! NSArray).object(at: indexPath.row) as! NSNumber)) hPa"
        
        /////////////////////////////////////////////////////////////////////
        
        let get_wind = Double(((self.weatherArray.value(forKey: "wind") as! NSArray).value(forKey: "speed") as! NSArray).object(at: indexPath.row) as! NSNumber)
        
        let convrt_speed = Int(ceil(get_wind * 3.6))
        
        cell.wind.text = "\(String(convrt_speed)) Km/h"
        
        cell.visibility.text = String(describing: ((((self.weatherArray.value(forKey: "weather") as! NSArray).object(at: indexPath.row) as! NSArray).value(forKey: "description") as! NSArray)).object(at: 0) as! String)
        
        let weathericon = ((((self.weatherArray.value(forKey: "weather") as! NSArray).object(at: indexPath.row) as! NSArray).value(forKey: "icon") as! NSArray)).object(at: 0) as! String
        
        let iconlink = "\(imgbaseurl)\(weathericon).png"
        print("iconlink = \(iconlink)")
        
        let url = URL.init(string: iconlink)
        
        cell.weather_icon.sd_setImage(with: url!)
        
        
        return cell
    }
    
    
    
    
    @IBAction func back(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension String
{
    func trim() -> String
    {
        return self.trimmingCharacters(in: NSCharacterSet.whitespaces)
    }
}

