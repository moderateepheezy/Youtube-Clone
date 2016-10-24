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
    
    let baseUrl = "https://s3-us-west-2.amazonaws.com/youtubeassets"
    
    func fetchVideos(completion: @escaping ([Video]) -> ()){
        
        fetchFeedForUrlString(urlString: "\(baseUrl)/home.json", completion: completion)
    }
    
    
    func fetchTrendingFeed(completion: @escaping ([Video]) -> ()){

        fetchFeedForUrlString(urlString: "\(baseUrl)/trending.json", completion: completion)
    }

    func fetchSubscriptionFeed(completion: @escaping ([Video]) -> ()){
        fetchFeedForUrlString(urlString: "\(baseUrl)/subscriptions.json", completion: completion)
    }
    
    func fetchFeedForUrlString(urlString: String, completion: @escaping ([Video]) -> ()){
        
        let url = NSURL(string: urlString)!
        
        URLSession.shared.dataTask(with: url as URL) { (data, responseUrl, error) -> Void in
            if error != nil{
                print(error)
                return
            }
            
            do{
                if let wrappedData = data{
                    if let jsonDictionaries = try JSONSerialization.jsonObject(with: wrappedData, options: .mutableContainers) as? [[String: AnyObject]]{
                        
                        let videos = jsonDictionaries.map({return Video(dictionary: $0)})
                        
                        DispatchQueue.main.async {
                            completion(videos)
                        }
                        
                    }
                    
                }
                
                
            }catch let jsonError{
                print(jsonError)
            }
            
            }.resume()
    }

}
