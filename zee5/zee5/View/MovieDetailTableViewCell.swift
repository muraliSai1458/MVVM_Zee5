//
//  MovieDetailTableViewCell.swift
//  zee5
//
//  Created by Pavan on 7/21/18.
//  Copyright © 2018 Saven Developer. All rights reserved.
//

import UIKit

class MovieDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var label_Title: UILabel!
    @IBOutlet weak var label_Value: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
