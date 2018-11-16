//
//  Utilitys.swift
//  NYTimes
//
//  Created by Damu on 16/11/18.
//  Copyright © 2018 Damu. All rights reserved.
//

import Foundation
import UIKit
class Utilitys {
    
    
}
extension UIViewController{
    /// Stops Loading
        func stopLoading()  {
        let someview = self.view.viewWithTag(999)
        UIView.animate(withDuration: 0, delay: 0, options: .transitionFlipFromTop , animations: {
            someview?.layer.opacity = 0.01
        }) { (finished) in
            someview?.removeFromSuperview()
            self.view.isUserInteractionEnabled = true
        }
    }
    /// Shows Loading
    func startLoading() {
        let loadingView = UIView()
        loadingView.tag = 999
        loadingView.layer.cornerRadius = 10.0
        loadingView.backgroundColor = .black
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(loadingView)
        let label = UILabel()
        let activity = UIActivityIndicatorView(style: .whiteLarge)
        activity.startAnimating()
        activity.color = UIColor.white
        label.textColor = UIColor.white
        activity.translatesAutoresizingMaskIntoConstraints = false
        loadingView.addSubview(activity)
        label.text = "Loading.."
        label.translatesAutoresizingMaskIntoConstraints = false
        loadingView.addSubview(label)
        let visualDict = ["loadingview":loadingView,"label":label,"activity":activity,"mainview":self.view]
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[mainview]-(<=0)-[loadingview(100)]", options: NSLayoutConstraint.FormatOptions.alignAllCenterY, metrics: nil, views: visualDict as Any as! [String : Any]))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[mainview]-(<=0)-[loadingview(100)]", options: NSLayoutConstraint.FormatOptions.alignAllCenterX, metrics: nil, views: visualDict as Any as! [String : Any]))
        loadingView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[loadingview]-(<=0)-[activity]", options:NSLayoutConstraint.FormatOptions.alignAllCenterX, metrics: nil, views: visualDict as Any as! [String : Any]))
        loadingView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-20-[activity]", options:[], metrics: nil, views: visualDict as Any as! [String : Any]))
        loadingView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[activity]-(<=8)-[label]", options:NSLayoutConstraint.FormatOptions.alignAllCenterX, metrics: nil, views: visualDict as Any as! [String : Any]))
        self.view.isUserInteractionEnabled = false
    }
}
extension UIImageView {
    /// Image Downloading
    func downloadedFrom(url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { () -> Void in
                self.image = image
            }
            }.resume()
    }
    func downloadedFrom(link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloadedFrom(url: url, contentMode: mode)
    }
}
