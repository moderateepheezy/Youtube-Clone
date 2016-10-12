//
//  Video.swift
//  Youtube-Clone
//
//  Created by SimpuMind on 10/9/16.
//  Copyright © 2016 SimpuMind. All rights reserved.
//

import UIKit

class Video: NSObject {
    
    var thumbnailImageName: String?
    var title: String?
    var channel: Channel?
    
    var numberOfviews: NSNumber?
    var uploadDate: NSDate?
    
}

class Channel: NSObject{
    var name: String?
    var profileImageName: String?
}
