//
//  CompanyCollectionViewCell.swift
//  PromoHunt
//
//  Created by David Elsonbaty on 2/12/17.
//  Copyright © 2017 David Elsonbaty. All rights reserved.
//

import UIKit

class CompanyCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var companyColorView: UIView!
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var companyImageView: UIImageView!
    
    var company: Company?
    
}
