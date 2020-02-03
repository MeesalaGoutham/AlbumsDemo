//
//  ImageDownloader.swift
//  AlbumsDemo
//
//  Created by Goutham Nani on 1/31/20.
//  Copyright © 2020 Goutham Nani. All rights reserved.
//

import UIKit

class ImageDownloader {
    
    static let shared = ImageDownloader()
    
    private init() {}
    
    let session = URLSession(configuration: .default)

    func downloadImage(url: URL, save: Bool, _ completion: @escaping (UIImage?, URL?) -> Void) {
        let task = session.dataTask(with: url) { (data, response, error) in
            
            guard let data = data else {
                completion(nil, response?.url)
                return
            }
            
            if let image = UIImage(data: data) {
                if save { ImagesCache.shared.set(image, forKey: url.absoluteString) }
                completion(image, response?.url)
            }
        }
        task.resume()
    }
    
}
