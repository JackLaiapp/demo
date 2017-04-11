//
//  nameTableViewCell.swift
//  demo6
//
//  Created by MyMac on 2017/3/27.
//  Copyright © 2017年 Jack Lai. All rights reserved.
//

import UIKit

class nameTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
