//
//  ShimmerView.swift
//  PromoHunt
//
//  Created by David Elsonbaty on 2/19/17.
//  Copyright © 2017 David Elsonbaty. All rights reserved.
//

import Shimmer
import CommonUtilities

class ShimmerView: FBShimmeringView {
    
    var shimmerColor: UIColor? {
        get { return contentView.backgroundColor }
        set { contentView.backgroundColor = newValue }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInitalization()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInitalization()
    }
    
    func commonInitalization() {
        
        let contentView = View()
        contentView.proportionalCornerRadius = .circular
        contentView.backgroundColor = UIColor.white.withAlphaComponent(0.1)
        self.contentView = contentView
        
        isShimmering = true
        shimmeringSpeed = 140
        shimmeringOpacity = 0.2
        backgroundColor = .clear
    }
}
