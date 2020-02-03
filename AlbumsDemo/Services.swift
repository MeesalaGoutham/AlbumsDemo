//
//  Services.swift
//  AlbumsDemo
//
//  Created by Goutham Nani on 1/31/20.
//  Copyright © 2020 Goutham Nani. All rights reserved.
//

import Foundation

struct API {
    static let albums = "https://rss.itunes.apple.com/api/v1/us/itunes-u/top-itunes-u-courses/all/%d/explicit.json"
}

class Services {
        
    static let shared = Services()
    private init() {}
    
    private let session = URLSession(configuration: .default)

    func fetchFeedData(upto: Int, _ completion: @escaping (FeedData?, Error?) -> Void) {
        let urlString = String(format: API.albums, upto)
        
        if let url = URL(string: urlString) {
            let task = session.dataTask(with: url) { (data, response, error) in
                guard let data = data else {
                    completion(nil, error)
                    return
                }
                
                if let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any], let feed = json["feed"] as? [String: Any] {
                    let feedData = FeedData()
                    feedData.readJson(feed)
                    completion(feedData, nil)
                }
                else {
                    completion(nil, error)
                }
            }
            task.resume()
        }
        else {
            completion(nil, nil)
        }
    }
    
}
