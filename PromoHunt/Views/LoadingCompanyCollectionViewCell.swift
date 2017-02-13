//
//  LoadingCompanyCollectionViewCell.swift
//  PromoHunt
//
//  Created by David Elsonbaty on 2/10/17.
//  Copyright © 2017 David Elsonbaty. All rights reserved.
//

import UIKit
import SnapKit
import Shimmer
import CommonUtilities

class CompanyLoadingCellSpec {

    static var textPlaceholderBackgroundColor: UIColor = UIColor(hex: "FFFFFF").withAlphaComponent(0.05)
    static func backgroundColor(at indexPath: IndexPath) -> UIColor {
        func isIndexFirstColor(index: Int) -> Bool {
            return index.isEven && CGFloat(index).truncatingRemainder(dividingBy: 4.0) == 0
        }
        return (isIndexFirstColor(index: indexPath.item) || isIndexFirstColor(index: indexPath.item.successor)) ? UIColor(hex: "#282828") : UIColor(hex: "#303030")
    }
    static func numberOfCells(in collectionView: UICollectionView) -> Int {
        return Int(collectionView.bounds.height.divided(by: collectionView.bounds.width).multiplied(by: 4.0).rounded(.up))
    }
}

class LoadingCompanyCollectionViewCell: UICollectionViewCell {
    
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

    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
