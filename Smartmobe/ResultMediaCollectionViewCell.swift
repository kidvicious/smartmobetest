//
//  ResultMediaCollectionViewCell.swift
//  Smartmobe
//
//  Created by Asmin Ghale on 4/11/19.
//  Copyright © 2019 default. All rights reserved.
//

import UIKit
import Kingfisher

class ResultMediaCollectionViewCell: UICollectionViewCell {
    
    var media: MediaResult!{
        didSet{
            if let url = media.url{
                let _url = URL(string: url)!
              imageView.kf.setImage(with: _url)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.layer.cornerRadius = 5
        imageView.layer.masksToBounds = true
    }
    
    
    @IBOutlet weak var imageView: UIImageView!
    
}
