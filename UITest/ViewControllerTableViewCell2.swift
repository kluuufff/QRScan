//
//  ViewControllerTableViewCell2.swift
//  UITest
//
//  Created by iHope on 19.03.2018.
//  Copyright © 2018 iHope. All rights reserved.
//

import UIKit

class ViewControllerTableViewCell2: UITableViewCell {
    
    @IBOutlet weak var picProducts: UIImageView!
    @IBOutlet weak var urlText: UITextView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
