//
//  AlertManager.swift
//  CarBuy
//
//  Created by admin on 4/9/19.
//  Copyright © 2019 admin. All rights reserved.
//

import Foundation
import UIKit

class AlertManager {
    
    static let shared = AlertManager()
    
    private init() {}
    
    func displayAlert(vc: UIViewController,title: String, message: String) -> Void {
        DispatchQueue.main.async {
            let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertVC.addAction(okButton)
            vc.present(alertVC, animated: true, completion: nil)
        }
        
    }
    
    func displayAlertWithAction(vc: UIViewController, title: String, cancelButtonName: String, message: String, actionButtonName: String, action: @escaping (()-> Void)) -> Void {
        DispatchQueue.main.async {
            let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let okButton = UIAlertAction(title: cancelButtonName, style: .default, handler: nil)
            let retryButton = UIAlertAction(title: actionButtonName, style: .destructive) { (handler) in
                action()
            }
            alertVC.addAction(okButton)
            alertVC.addAction(retryButton)
            vc.present(alertVC, animated: true, completion: nil)
        }
        
    }

    func displayAlertWithRetryAction(vc: UIViewController, title: String, message: String, actionButtonName: String, action: @escaping (()-> Void)) -> Void {
        DispatchQueue.main.async {
            let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let retryButton = UIAlertAction(title: actionButtonName, style: .destructive) { (handler) in
                action()
            }
            alertVC.addAction(retryButton)
            vc.present(alertVC, animated: true, completion: nil)
        }
        
    }
    
}


