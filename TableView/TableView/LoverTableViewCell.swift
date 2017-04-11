//
//  LoverTableViewCell.swift
//  TableView
//
//  Created by MyMac on 2017/3/13.
//  Copyright © 2017年 Jack Lai. All rights reserved.
//

import UIKit

class LoverTableViewCell: UITableViewCell {

    @IBOutlet var photoImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
