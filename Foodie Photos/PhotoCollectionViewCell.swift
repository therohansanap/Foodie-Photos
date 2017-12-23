//
//  PhotoCollectionViewCell.swift
//  Foodie Photos
//
//  Created by Rohan Sanap on 22/12/17.
//  Copyright © 2017 The Rohan Sanap Tech Studios. All rights reserved.
//

import UIKit
import AlamofireImage

class PhotoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    func setDefault() {
        imageView.image = UIImage(named: "placeholder")
        titleLabel.text = ""
    }
    
    func setFor(_ collection: Collection) {
        titleLabel.text = collection.title
        
        if let imgUrlString = collection.imgUrl {
            if let imgUrl = URL(string: imgUrlString) {
                imageView.af_setImage(withURL: imgUrl)
            }
        }
    }
}
