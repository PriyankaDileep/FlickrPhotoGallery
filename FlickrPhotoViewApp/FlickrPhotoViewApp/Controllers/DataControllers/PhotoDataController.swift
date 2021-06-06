//
//  PhotoDataController.swift
//  FlickrPhotoViewApp
//
//  Created by Priyanka PS on 6/6/21.
//

import Foundation


final class PhotoDataController {
    
static let shared: PhotoDataController = PhotoDataController()
    
private func flickrURLFromParameters() -> URL {
        
        // Build base URL
        var components = URLComponents()
        components.scheme = APIConstants.FlickrURLParams.APIScheme
        components.host = APIConstants.FlickrURLParams.APIHost
        components.path = APIConstants.FlickrURLParams.APIPath
        
        // Build query string
        components.queryItems = [URLQueryItem]()
        
        // Query components
    components.queryItems!.append(URLQueryItem(name: APIConstants.FlickrAPIKeys.getPublicPhotoMethod, value: APIConstants.FlickrAPIValues.getPublicPhotoMethod));
        components.queryItems!.append(URLQueryItem(name: APIConstants.FlickrAPIKeys.APIKey, value: APIConstants.FlickrAPIValues.APIKey));
       components.queryItems!.append(URLQueryItem(name: APIConstants.FlickrAPIKeys.userID, value: APIConstants.FlickrAPIValues.userID));
        components.queryItems!.append(URLQueryItem(name: APIConstants.FlickrAPIKeys.ResponseFormat, value: APIConstants.FlickrAPIValues.ResponseFormat));
        components.queryItems!.append(URLQueryItem(name: APIConstants.FlickrAPIKeys.Extras, value: APIConstants.FlickrAPIValues.MediumURL));
        components.queryItems!.append(URLQueryItem(name: APIConstants.FlickrAPIKeys.SafeSearch, value: APIConstants.FlickrAPIValues.SafeSearch));
        components.queryItems!.append(URLQueryItem(name: APIConstants.FlickrAPIKeys.DisableJSONCallback, value: APIConstants.FlickrAPIValues.DisableJSONCallback));
        return components.url!
    }
    
     func getPhotosFromFlickrAPI(completion: @escaping (Result<PhotosModel,
                                                                      Error>) -> Void) {
        let session = URLSession.shared
        let baseURL = flickrURLFromParameters()
        print("URL: \(baseURL)")
        let task = session.dataTask(with: baseURL) { (data, response, error) in
            guard error == nil else {
                print("Error. Data task completed with an error\(String(describing: error))")
                return
            }
            if let data = data {
                print(data)
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(PhotosModel.self, from: data)
                    completion(.success(response))
                    print(data)

                } catch let DecodingError.dataCorrupted(context) {
                    print(context)
                } catch let DecodingError.keyNotFound(key, context) {
                    print("Key '\(key)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch let DecodingError.valueNotFound(value, context) {
                    print("Value '\(value)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch let DecodingError.typeMismatch(type, context)  {
                    print("Type '\(type)' mismatch:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch {
                    print("error: ", error)
                }
            } else if let error = error {
                completion(.failure(error))
            }
        }
        task.resume()
    }


}
