//
//  ImagesCache.swift
//  AlbumsDemo
//
//  Created by Goutham Nani on 1/31/20.
//  Copyright © 2020 Goutham Nani. All rights reserved.
//

import UIKit

class ImagesCache {
    
    static let shared = ImagesCache()
    
    private let imageCache = NSCache<NSString, UIImage>()
    
    func set(_ image: UIImage, forKey key: String) {
        imageCache.setObject(image, forKey: key as NSString)
    }
    
    func image(forKey key: String) -> UIImage? {
        return imageCache.object(forKey: key as NSString)
    }
    
}
