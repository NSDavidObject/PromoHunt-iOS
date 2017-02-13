//
//  CompanyLoadingCollectionViewCell.swift
//  PromoHunt
//
//  Created by David Elsonbaty on 2/10/17.
//  Copyright © 2017 David Elsonbaty. All rights reserved.
//

import UIKit
import Shimmer
import SnapKit
import CommonUtilities

class CompanyLoadingCollectionViewCellSpec {

    static func backgroundColor(at indexPath: IndexPath) -> UIColor {
        func isIndexFirstColor(index: Int) -> Bool {
            return index.isEven && CGFloat(index).truncatingRemainder(dividingBy: 4.0) == 0
        }
        let isLightColoredCell = (isIndexFirstColor(index: indexPath.item) || isIndexFirstColor(index: indexPath.item.successor))
        return isLightColoredCell ? AppColors.lightGrey : AppColors.dardGrey
    }
    static func numberOfCells(in collectionView: UICollectionView) -> Int {
        return Int(collectionView.bounds.height.divided(by: collectionView.bounds.width).multiplied(by: 4.0).rounded(.up))
    }
}

class CompanyLoadingCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var shimmerView: FBShimmeringView!
    @IBOutlet weak var shimmerContentView: View!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        shimmerView.isShimmering = true
        shimmerView.shimmeringSpeed = 140
        shimmerView.shimmeringOpacity = 0.2
        shimmerView.backgroundColor = UIColor.clear
        shimmerView.contentView = shimmerContentView
        
        shimmerContentView.proportionalCornerRadius = .circular
        shimmerContentView.backgroundColor = UIColor.white.withAlphaComponent(0.1)
    }
}
