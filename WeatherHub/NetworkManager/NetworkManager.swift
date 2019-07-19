//
//  NetworkManager.swift
//  WeatherHub
//
//  Created by Dipak Singh on 4/9/19.
//  Copyright © 2017 admin. All rights reserved.
//

import Foundation
import UIKit


enum ApiError: Error {
    case noDataAvailable
    case cannotProcessData
}


class NetworkManager {
    
    static let shared = NetworkManager()
    private init() {}
    
    private let session = URLSession.shared
    private var task: URLSessionDataTask? = nil
    
    typealias response = (_ data: Data?, _ error: String)-> Void
    
    
    func getMethod(link: String?, headers: [String:String], completionHandler: @escaping (response) ) {
        
        guard let link = link else {return}
        let url = URL(string: link)!
        var request = URLRequest(url: url)
        if headers.count != 0 {
            request.allHTTPHeaderFields = headers
        }
        request.httpMethod = "GET"

        task = session.dataTask(with: request, completionHandler: { (data, response, error) in
            
            if error != nil {
                completionHandler(data, error!.localizedDescription)
            }
            else {
                completionHandler(data, "")
            }
            
        })
        task?.resume()
    }
}
