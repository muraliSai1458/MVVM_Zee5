//
//  MoviedetailOverviewTableViewCell.swift
//  zee5
//
//  Created by Pavan on 7/21/18.
//  Copyright © 2018 Saven Developer. All rights reserved.
//

import UIKit

class MoviedetailOverviewTableViewCell: UITableViewCell {

    @IBOutlet weak var label_Overview: UILabel!
    @IBOutlet weak var button_Showfull: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
