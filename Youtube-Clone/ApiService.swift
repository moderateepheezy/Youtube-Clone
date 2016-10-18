//
//  ApiService.swift
//  Youtube-Clone
//
//  Created by SimpuMind on 10/18/16.
//  Copyright © 2016 SimpuMind. All rights reserved.
//

import UIKit

class ApiService: NSObject {

    static let sharedInstance = ApiService()
    
    func fectchVideos(completion: @escaping ([Video]) -> ()){
        let url = NSURL(string: "https://s3-us-west-2.amazonaws.com/youtubeassets/home.json")!
        
        URLSession.shared.dataTask(with: url as URL) { (data, responseUrl, error) -> Void in
            if error != nil{
                print(error)
                return
            }
            
            do{
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                
                var videos = [Video]()
                
                for dictionary in json as! [[String: AnyObject]]{
                    
                    let video = Video()
                    video.title = dictionary["title"] as? String
                    video.thumbnailImageName =
                        dictionary["thumbnail_image_name"] as? String
                    
                    let channel = Channel()
                    let channelDic = dictionary["channel"] as? [String:AnyObject]
                    channel.name = channelDic?["name"] as? String
                    print("notThisWait\(channelDic?["name"] as? String)")
                    channel.profileImageName = channelDic?["profile_image_name"] as? String
                    
                    video.channel = channel
                    
                    videos.append(video)
                }
                DispatchQueue.main.async {
                    completion(videos)
                }
                
                
            }catch let jsonError{
                print(jsonError)
            }
            
            }.resume()
    }
}
