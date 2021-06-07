//
//  Photo.swift
//  FlickrPhotoViewApp
//
//  Created by Priyanka PS on 5/6/21.
//

import Foundation

struct PhotosModel: Codable {
    let photos: Photos
}

struct Photos: Codable {
    let photo: [Photo]
}
struct Photo: Codable, Equatable {
    var title: String
    var name: String
    var id: String
    var server: String
    var secret: String
    var url: URL
    
    
    enum CodingKeys: String, CodingKey {
            case title
            case name = "ownername"
            case id
            case server
            case secret
            case url = "url_m"
        }
    
    init(from decoder: Decoder) throws {
            let valueContainer = try decoder.container(keyedBy:
                                                        CodingKeys.self)
            self.title = try valueContainer.decode(String.self,
               forKey: CodingKeys.title)
            self.name = try valueContainer.decode(String.self,
               forKey: CodingKeys.name)
            self.url = try valueContainer.decode(URL.self, forKey:                                                    CodingKeys.url)
            self.id = try valueContainer.decode(String.self,
               forKey: CodingKeys.id)
            self.server = try valueContainer.decode(String.self,
            forKey: CodingKeys.server)
            self.secret = try valueContainer.decode(String.self,
            forKey: CodingKeys.secret)
        }
    
    
//    func flickrImageURL() -> String {
//        let path = "https://live.staticflickr.com/\(server)/\(id)_\(secret).jpg"
//        return path
//    }
}
