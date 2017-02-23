//
//  PromoTableViewCell.swift
//  PromoHunt
//
//  Created by David Elsonbaty on 2/19/17.
//  Copyright © 2017 David Elsonbaty. All rights reserved.
//

import UIKit

class PromoTableViewCellSpec {
    static let cellHeight: CGFloat = 60.0
}

class PromoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var labelView: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = AppColors.black
    }
}
