//
//  ShimmerView.swift
//  PromoHunt
//
//  Created by David Elsonbaty on 2/10/17.
//  Copyright © 2017 David Elsonbaty. All rights reserved.
//

import Shimmer
import CommonUtilities

class ShimmerView: FBShimmeringView {

    public var proportionalCornerRadius: ProportionalCornerRadius?

    // MARK: Layout
    override public func layoutSubviews() {
        super.layoutSubviews()
        roundCorners()
    }

    func roundCorners() {
        if let proportionalCornerRadius = proportionalCornerRadius {
            self.layer.roundCorners(withRadius: proportionalCornerRadius.cornerRadius(forSize: self.bounds.size))
        }
    }
}
