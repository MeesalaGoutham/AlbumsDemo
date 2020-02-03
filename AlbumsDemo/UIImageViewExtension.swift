//
//  UIImageViewExtension.swift
//  AlbumsDemo
//
//  Created by Goutham Nani on 1/31/20.
//  Copyright © 2020 Goutham Nani. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func setImage(fromUrl url: URL) {
        if let cachedImage = ImagesCache.shared.image(forKey: url.absoluteString) {
            self.image = cachedImage
        }
        else {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { [weak self] (data, response, error) in
                
                guard let data = data else { return }
                
                if let image = UIImage(data: data) {
                    ImagesCache.shared.set(image, forKey: url.absoluteString)
                    DispatchQueue.main.async {
                        self?.image = image
                        self?.layoutSubviews()
                    }
                }
            }
            task.resume()
        }
    }
    
}
