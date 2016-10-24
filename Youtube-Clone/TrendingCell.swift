//
//  TrendingCell.swift
//  Youtube-Clone
//
//  Created by SimpuMind on 10/18/16.
//  Copyright © 2016 SimpuMind. All rights reserved.
//

import UIKit

class TrendingCell: FeedCell {

    override func fetchVideos() {
        ApiService.sharedInstance.fetchTrendingFeed { (videos: [Video]) in
            
            self.videos = videos
            self.collectionView.reloadData()
        }
    }

}
