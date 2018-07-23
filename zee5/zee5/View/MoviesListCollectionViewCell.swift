//
//  MoviesListCollectionViewCell.swift
//  zee5
//
//  Created by Saven Developer on 7/20/18.
//  Copyright © 2018 Saven Developer. All rights reserved.
//

import UIKit

class MoviesListCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var image_Movie: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        image_Movie.contentMode = .scaleAspectFill
        
        
    }
}
