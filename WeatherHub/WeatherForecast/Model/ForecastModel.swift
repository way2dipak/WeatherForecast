//
//  ForecastModel.swift
//  WeatherHub
//
//  Created by admin on 19/07/19.
//  Copyright © 2019 kamlesh kumar. All rights reserved.
//

import Foundation


struct WeatherModel: Codable {
    let cod: String
    let message: Double
    let cnt: Int
    let list: [List]
    let city: City
}

// MARK: - City
struct City: Codable {
    let id: Int
    let name: String
    let coord: Coord
    let country: String
    let population, timezone: Int
}

// MARK: - Coord
struct Coord: Codable {
    let lat, lon: Double
}

// MARK: - List
struct List: Codable {
    let dt: Int
    let main: MainClass
    let weather: [Weather]
    let clouds: Clouds
    let wind: Wind
    let rain: Rain?
    let sys: Sys
    let dtTxt: String
    
    enum CodingKeys: String, CodingKey {
        case dt, main, weather, clouds, wind, rain, sys
        case dtTxt = "dt_txt"
    }
}

// MARK: - Clouds
struct Clouds: Codable {
    let all: Int
}

// MARK: - MainClass
struct MainClass: Codable {
    let temp, tempMin, tempMax, pressure: Double
    let seaLevel, grndLevel: Double
    let humidity: Int
    let tempKf: Double
    
    enum CodingKeys: String, CodingKey {
        case temp
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
        case humidity
        case tempKf = "temp_kf"
    }
}

// MARK: - Rain
struct Rain: Codable {
    let the3H: Double?
    
    enum CodingKeys: String, CodingKey {
        case the3H = "3h"
    }
}

// MARK: - Sys
struct Sys: Codable {
    let pod: Pod
}

enum Pod: String, Codable {
    case d = "d"
    case n = "n"
}

// MARK: - Weather
struct Weather: Codable {
    let id: Int
    let main: MainEnum
    let weatherDescription, icon: String
    
    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
}

enum MainEnum: String, Codable {
    case clear = "Clear"
    case clouds = "Clouds"
    case rain = "Rain"
}

// MARK: - Wind
struct Wind: Codable {
    let speed, deg: Double
}

struct ForeCastModel {
    
    func getWeatherDetails(link: String, completion: @escaping(Result<[List], ApiError>)-> Void) {
        NetworkManager.shared.getMethod(link: link, headers: [:]) { (data, error) in
            if error != "" {
                completion(.failure(.noDataAvailable))
            }
            else {
                guard let newData = data else {
                    print("Failed to getData👹")
                    return
                }
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(WeatherModel.self, from: newData)
                    if response.cod == "200" {
                        completion(.success(response.list))
                    }
                    else {
                        completion(.failure(.noDataAvailable))
                    }
                }
                catch let parsingError {
                    print("ParsingError: \(parsingError)")
                    completion(.failure(.cannotProcessData))
                }
            }
        }
    }
}
