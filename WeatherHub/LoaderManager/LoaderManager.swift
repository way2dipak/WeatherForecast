//
//  LoaderManager.swift
//  CarBuy
//
//  Created by admin on 4/9/19.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit
//import SwiftyGif

class LoaderManager: UIView {
    
    
    static let shared = LoaderManager()
    
    lazy var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
        
        spinner.center = transparentView.center
        spinner.style = .whiteLarge
        spinner.tintColor = UIColor.blue
        spinner.backgroundColor = UIColor.darkGray
        spinner.hidesWhenStopped = true
        return spinner
    }()
    
    lazy var transparentView: UIView = {
        let transparentView = UIView(frame: UIScreen.main.bounds)
        transparentView.backgroundColor = UIColor.black.withAlphaComponent(0.0)
        DispatchQueue.main.async {
            transparentView.isUserInteractionEnabled = false
        }
        return transparentView
    }()
    /*
    lazy var gifImage: UIImageView = {
        let gif = UIImageView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
        gif.contentMode = .scaleToFill
        gif.center = transparentView.center
        DispatchQueue.main.async {
            gif.isUserInteractionEnabled = false
        }
        let gifImg = UIImage(gifName: "Loader.gif")
        gif.setGifImage(gifImg)
        return gif
    }()
    */
    func showLoader() {
        DispatchQueue.main.async {
            self.addSubview(self.transparentView)
            //self.transparentView.addSubview(self.gifImage)
            self.transparentView.addSubview(self.spinner)
            self.transparentView.bringSubviewToFront(self.spinner)
            self.spinner.startAnimating()
            UIApplication.shared.keyWindow?.addSubview(self.transparentView)
        }
    }
    
    func hideLoader() {
        DispatchQueue.main.async {
            self.transparentView.isUserInteractionEnabled = true
            self.spinner.stopAnimating()
            self.transparentView.removeFromSuperview()
        }
    }
}
