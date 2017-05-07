//
//  MyTableViewCell.swift
//  Search Movie DB
//
//  Created by Md Asif Huda on 5/7/17.
//  Copyright © 2017 Md Asif Huda. All rights reserved.
//

import UIKit

class MyTableViewCell: UITableViewCell {
    @IBOutlet weak var movieName: UILabel!

    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
