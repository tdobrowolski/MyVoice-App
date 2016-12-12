//
//  FirstViewControllerTableViewCell.swift
//  MyVoice
//
//  Created by Tobiasz Dobrowolski on 09.12.2016.
//  Copyright © 2016 Infinite. All rights reserved.
//

import UIKit

class FirstViewControllerTableViewCell: UITableViewCell {

    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var myBackground: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
