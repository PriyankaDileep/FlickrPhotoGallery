//
//  NetworkErrors.swift
//  FlickrPhotoViewApp
//
//  Created by Priyanka PS on 7/6/21.
//

import Foundation

enum NetworkErrors: CustomDebugStringConvertible, Error {
    case httpError(statusCode: Int)
    case invalidData
    case parseJsonFailed(Error)
    case invalidURL
    case unableToComplete(Error)
    case other

    var debugDescription: String {
        switch self {
        case .httpError(let code):
            return "HTTP error code \(code)."
        case .unableToComplete(let error):
            return "\(error.localizedDescription)"
        case .parseJsonFailed(let error):
            return "Cannot decode JSON data, \(error)"
        case .invalidData:
            return "Data received from the server was invalid. Please try again."
        case .invalidURL:
            return "Invalid URL."
        case .other:
            return "Please check your internet and try again."
        }
    }
}
