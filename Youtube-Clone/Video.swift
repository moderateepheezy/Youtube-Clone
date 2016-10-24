//
//  Video.swift
//  Youtube-Clone
//
//  Created by SimpuMind on 10/9/16.
//  Copyright © 2016 SimpuMind. All rights reserved.
//

import UIKit

class SafeJsonObject: NSObject{
    
    override func setValue(_ value: Any?, forKey key: String) {
        
        let upperCasedFirstCharacter = String(key.characters.first!).uppercased()
        
        let range = key.startIndex..<key.index(key.startIndex, offsetBy: 1)
        
        let selectorString = key.replacingCharacters(in: range, with: upperCasedFirstCharacter)
        
//        let remainder = key.substring(from: key.characters.index(after: key.characters.startIndex))
//
//        let sele = "set\(upperCasedFirstCharacter)\(remainder)"
        
        
        let selector = NSSelectorFromString("set\(selectorString):")
        
        let responds = self.responds(to: selector)
        
        if !responds{
            return
        }
        
        super.setValue(value, forKey: key)
    }
}

class Video: SafeJsonObject {
    
    var thumbnail_image_name: String?
    var title: String?
    var channel: Channel?
    var duration: NSNumber?
    var number_of_views: NSNumber?
    var uploadDate: NSDate?
    
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "channel"{
        
             self.channel = Channel()
            
            self.channel?.setValuesForKeys((value as? [String:AnyObject])!)
            
        }else{
            super.setValue(value, forKey: key)
        }
    }
    
    init(dictionary: [String: AnyObject]){
        super.init()
        setValuesForKeys(dictionary)
    }
    
}

class Channel: SafeJsonObject{
    var name: String?
    var profile_image_name: String?
}
