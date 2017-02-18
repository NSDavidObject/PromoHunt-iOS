//
//  CompanyCollectionViewCell.swift
//  PromoHunt
//
//  Created by David Elsonbaty on 2/12/17.
//  Copyright © 2017 David Elsonbaty. All rights reserved.
//

import UIKit

class CompanyCollectionViewCell: UICollectionViewCell {
    
    var company: Company?
    var companyDetailsView: CompanyDetailsView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        companyDetailsView = CompanyDetailsView.instanceFromNib() 
        contentView.addSubview(companyDetailsView)
        companyDetailsView.snp.makeConstraints { maker in
            maker.edges.equalTo(contentView)
        }
    }
}
