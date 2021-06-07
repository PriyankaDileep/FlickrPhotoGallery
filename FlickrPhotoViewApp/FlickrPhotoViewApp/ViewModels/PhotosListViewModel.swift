//
//  PhotosListViewModel.swift
//  FlickrPhotoViewApp
//
//  Created by Priyanka PS on 7/6/21.
//

import Foundation

final class PhotosListViewModel {
    var photosList = [Photo]()
    func fetchPhotos(completion: @escaping (Result<Bool, NetworkErrors>) -> Void) {
        PhotoDataController.shared.getPhotosFromFlickrAPI { (result) in
            switch result {
            case .success(let photosModel):
                self.photosList = photosModel.photos.photo
                print(self.photosList)
                DispatchQueue.main.async {
                    completion(.success(true))
                }
            case .failure(let error):
                completion(.failure(error as! NetworkErrors))
                print(error.localizedDescription)
            }
        }
    }
}
