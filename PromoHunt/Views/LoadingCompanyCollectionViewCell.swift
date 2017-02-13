//
//  LoadingCompanyCollectionViewCell.swift
//  PromoHunt
//
//  Created by David Elsonbaty on 2/10/17.
//  Copyright © 2017 David Elsonbaty. All rights reserved.
//

import UIKit
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
    
    @IBOutlet weak var textPlaceholderView: ShimmerView!

    override func awakeFromNib() {
        super.awakeFromNib()

        let view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 30))
        view.backgroundColor = UIColor.white.withAlphaComponent(0.1)

        textPlaceholderView.contentView = view
        textPlaceholderView.isShimmering = true
        textPlaceholderView.shimmeringSpeed = 140
        textPlaceholderView.shimmeringOpacity = 0.2
        textPlaceholderView.backgroundColor = UIColor.clear
        textPlaceholderView.proportionalCornerRadius = .circular
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
