//
//  PhotoDisplaying.swift
//  FlickrPhotoViewApp
//
//  Created by Priyanka PS on 6/6/21.
//

import UIKit

protocol PhotoDisplaying {
    var photoImageView: UIImageView! { get set }
    var photoTitleLabel: UILabel! { get set }
    var photoGrapherNameLabel: UILabel! { get set }
}

extension PhotoDisplaying {
    func configure(for item: Photo, storeItemController: PhotoDataController) {
        photoTitleLabel.text = item.title
        photoGrapherNameLabel.text = item.name
        photoImageView?.image = UIImage(systemName: "photo")

        storeItemController.fetchImage(from: item.url) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let image):
                    self.photoImageView.image = image
                case .failure(let error):
                    self.photoImageView.image = UIImage(systemName: "photo")
                    print("Error fetching image: \(error)")
                }
            }
        }
    }
}
