//  Extensions.swift
//  Youtube-Clone
//
//  Created by SimpuMind on 10/9/16.
//  Copyright © 2016 SimpuMind. All rights reserved.
//

import UIKit

extension UIColor{
    static func rgb(red: CGFloat, green: CGFloat, blue:CGFloat) -> UIColor{
        return UIColor(red: red/225, green: green/225, blue: blue/225, alpha: 1)
    }
}

extension UIView{
    func addConstraintsWithFormat(format: String, views: UIView...){
        
        var viewDictionary = [String: UIView]()
        for(index, view) in views.enumerated(){
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewDictionary[key] = view
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewDictionary))
    }
}

extension UIImageView{
    
    func loadImageUsingUrlString(urlString: String){
        
        let url = NSURL(string: urlString)!
        let task = URLSession.shared.dataTask(with: url as URL) { (responseData, responseUrl, error) -> Void in
            if let data = responseData{
                
                DispatchQueue.main.async {
                    self.image = UIImage(data: data)
                }
                
            }
        }
        task.resume()
    }
}
