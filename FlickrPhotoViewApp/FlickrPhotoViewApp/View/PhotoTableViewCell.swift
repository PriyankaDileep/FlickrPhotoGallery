//
//  PhotoTableViewCell.swift
//  FlickrPhotoViewApp
//
//  Created by Priyanka PS on 6/6/21.
//

import UIKit

class PhotoTableViewCell: UITableViewCell,PhotoDisplaying {

    @IBOutlet weak var photoTitleLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var photoGrapherNameLabel: UILabel!
    @IBOutlet weak var favouriteButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
