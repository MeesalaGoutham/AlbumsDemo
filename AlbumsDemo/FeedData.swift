//
//  FeedData.swift
//  AlbumsDemo
//
//  Created by Goutham Nani on 1/31/20.
//  Copyright © 2020 Goutham Nani. All rights reserved.
//

import Foundation

class FeedData {
    var copyRight: String = ""
    var albums: [Album] = []
    
    func readJson(_ json: [String: Any]) {
        copyRight = json[Feed_Constants.copyRight] as? String ?? ""
        
        if let albumsAry = json[Feed_Constants.results] as? [[String: Any]] {
            albumsAry.forEach { (json) in
                var album = Album()
                album.readJson(json)
                album.copyRight = copyRight
                albums.append(album)
            }
        }
    }
}
