//
//  FavouritePhotoTableViewCell.swift
//  FlickrPhotoViewApp
//
//  Created by Priyanka PS on 7/6/21.
//

import UIKit

class FavouritePhotoTableViewCell: UITableViewCell, PhotoDisplaying {
   
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var favouriteButton: UIButton!
    @IBOutlet weak var photoTitleLabel: UILabel!
    @IBOutlet weak var photoGrapherNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
