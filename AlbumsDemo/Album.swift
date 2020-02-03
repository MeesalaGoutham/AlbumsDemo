//
//  Album.swift
//  AlbumsDemo
//
//  Created by Goutham Nani on 1/31/20.
//  Copyright © 2020 Goutham Nani. All rights reserved.
//

import Foundation

struct Genre {
    var genreId: String = ""
    var name: String = ""
    var url: URL?
    
    mutating func readJson(_ json: [String: Any]) {
        genreId = json[Feed_Constants.genreId] as? String ?? ""
        name = json[Feed_Constants.genreName] as? String ?? ""
        if let urlString = json[Feed_Constants.genreUrl] as? String {
            url = URL(string: urlString)
        }
    }
}

struct Album {
    var name: String = ""
    var artist: String = ""
    var artUrl: URL?
    var url: URL?
    var releaseDate: String = ""
    var copyRight: String = ""
    var genres: [Genre] = []

    mutating func readJson(_ json: [String: Any]) {
        name = json[Feed_Constants.name] as? String ?? ""
        artist = json[Feed_Constants.artist] as? String ?? ""
        releaseDate = json[Feed_Constants.releaseDate] as? String ?? ""
        if let urlString = json[Feed_Constants.artUrl] as? String {
            artUrl = URL(string: urlString)
        }
        if let urlString = json[Feed_Constants.url] as? String {
            url = URL(string: urlString)
        }
        
        if let genresAry = json[Feed_Constants.genres] as? [[String: Any]] {
            genresAry.forEach { (json) in
                var genre = Genre()
                genre.readJson(json)
                genres.append(genre)
            }
        }
    }
}
