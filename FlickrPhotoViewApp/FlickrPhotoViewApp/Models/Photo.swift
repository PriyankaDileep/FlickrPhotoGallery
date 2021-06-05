//
//  Photo.swift
//  FlickrPhotoViewApp
//
//  Created by Priyanka PS on 5/6/21.
//

import Foundation

struct Photo: Codable {
    var title: String
    var name: String
    var id: String
    var server: String
    var secret: String
    
    func flickrImageURL() -> String {
        let path = "https://live.staticflickr.com/\(server)/\(id)_\(secret).jpg"
        return path
    }
}
