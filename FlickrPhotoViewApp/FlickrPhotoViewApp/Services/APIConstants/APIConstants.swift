//
//  APIConstants.swift
//  FlickrPhotoViewApp
//
//  Created by Priyanka PS on 6/6/21.
//

import Foundation

struct APIConstants {
    
    struct FlickrURLParams {
        static let APIScheme = "https"
        static let APIHost = "api.flickr.com"
        static let APIPath = "/services/rest"
    }
    
    struct FlickrAPIKeys {
        static let getPublicPhotoMethod = "method"
        static let APIKey = "api_key"
        static let Extras = "extras"
        static let ResponseFormat = "format"
        static let DisableJSONCallback = "nojsoncallback"
        static let SafeSearch = "safe_search"
        static let Text = "text"
        static let userID = "user_id"
    }
    
    struct FlickrAPIValues {
        static let getPublicPhotoMethod = "flickr.people.getPublicPhotos"
        static let APIKey = "851395beaaec1b6428c6628c6d39f888"
        static let ResponseFormat = "json"
        static let DisableJSONCallback = "1"
        static let MediumURL = "url_m,owner_name"
        static let SafeSearch = "1"
        static let userID = "65789667@N06"
    }

}
