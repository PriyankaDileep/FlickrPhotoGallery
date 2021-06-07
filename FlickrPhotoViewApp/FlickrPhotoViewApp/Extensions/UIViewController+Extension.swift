//
//  UIViewController+Extension.swift
//  FlickrPhotoViewApp
//
//  Created by Priyanka PS on 7/6/21.
//

import Foundation
import UIKit

extension UIViewController {
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Something is wrong", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
