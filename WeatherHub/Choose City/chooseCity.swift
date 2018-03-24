//
//  chooseCity.swift
//  WeatherHub
//
//  Created by KAMLESH KUMAR on 22/03/18.
//  Copyright © 2018 kamlesh kumar. All rights reserved.
//

import UIKit

class chooseCity: UIViewController, UITableViewDelegate,UITableViewDataSource {
    
    var city_name_array = NSMutableArray()
    var City_img_array = NSMutableArray()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        city_name_array = ["Bangalore","Chennai","Kolkata","Mumbai","Delhi"]
        City_img_array = ["bangalore","chennai","kolkata","mumbai","delhi"]
        
    }
    
    
    
    
    //tableview code
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return city_name_array.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "citycell") as! ChooseCityCell
        
        
        
        
        cell.city_name.text = city_name_array[indexPath.row] as! String
        
        cell.city_img.clipsToBounds = true
        cell.city_img.layer.cornerRadius = cell.city_img.frame.size.width/2
        
        cell.city_img.image = UIImage.init(named: City_img_array[indexPath.row] as! String)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //disapper the selected index color
        tableView.deselectRow(at: indexPath, animated: true)
        
        //navigation code
        
        let screen = ScreenSize()
        
        let screen_height = screen.screen_height()
        
        if screen_height  == 812
        {
            if let viewController = UIStoryboard(name: "iphoneX", bundle: nil).instantiateViewController(withIdentifier: "forecast") as? Forecast {
                
                //passing the city name to next view controller
                viewController.city = self.city_name_array[indexPath.row] as! String
                
                if let navigator = navigationController {
                    navigator.pushViewController(viewController, animated: true)
                }
            }
        }else  if screen_height  == 736
        {
            if let viewController = UIStoryboard(name: "iphoneplus", bundle: nil).instantiateViewController(withIdentifier: "forecast") as? Forecast {
                
                //passing the city name to next view controller
                viewController.city = self.city_name_array[indexPath.row] as! String
                
                if let navigator = navigationController {
                    navigator.pushViewController(viewController, animated: true)
                }
            }
        }else  if screen_height  == 667
        {
            if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "forecast") as? Forecast {
                
                //passing the city name to next view controller
                viewController.city = self.city_name_array[indexPath.row] as! String
                
                if let navigator = navigationController {
                    navigator.pushViewController(viewController, animated: true)
                }
            }
        }else  if screen_height  == 568
        {
            if let viewController = UIStoryboard(name: "iphoneSE", bundle: nil).instantiateViewController(withIdentifier: "forecast") as? Forecast {
                
                //passing the city name to next view controller
                viewController.city = self.city_name_array[indexPath.row] as! String
                
                if let navigator = navigationController {
                    navigator.pushViewController(viewController, animated: true)
                }
            }
        }
        
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
