//
//  PromoLoadingTableViewCell.swift
//  PromoHunt
//
//  Created by David Elsonbaty on 2/19/17.
//  Copyright © 2017 David Elsonbaty. All rights reserved.
//

import UIKit

class PromoLoadingTableViewCell: UITableViewCell {
 
    @IBOutlet weak var shimmerView: ShimmerView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = AppColors.black
        shimmerView.shimmeringOpacity = 0.4
        shimmerView.shimmerColor = AppColors.lightGrey
    }
}
