//
//  CompanyDetailsView.swift
//  PromoHunt
//
//  Created by David Elsonbaty on 2/13/17.
//  Copyright © 2017 David Elsonbaty. All rights reserved.
//

import UIKit

class CompanyDetailsView: UIView {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var company: Company? {
        didSet {
            guard let company = company else { return }
            setup(with: company)
        }
    }
    
    static func copy(copying: CompanyDetailsView) -> CompanyDetailsView {
        let copy: CompanyDetailsView = CompanyDetailsView.instanceFromNib()
        copy.nameLabel.text = copying.nameLabel.text
        copy.imageView.image = copying.imageView.image
        return copy
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setup(with company: Company) {
        nameLabel.text = company.name
        CompanyOverlayedImageHelper.image(forCompany: company) { [weak self] response in
            guard let imageInfo = response.value, let strongSelf = self else { return }
            guard let currentCompany = strongSelf.company, currentCompany == imageInfo.company else { return }
            strongSelf.imageView.image = imageInfo.image
        }
    }
}

class OverlayedCompanyImageCache: MemoryCache<Company, UIImage> {
    static let shared = OverlayedCompanyImageCache()
}

class CompanyOverlayedImageHelper {
    
    static func image(forCompany company: Company, usingCache cacheUsability: CacheUsability<OverlayedCompanyImageCache> = .cache(OverlayedCompanyImageCache.shared), completion: @escaping ((ResponseReturn<(company: Company, image: UIImage)>) -> Void)) {
        
        let cache = cacheUsability.cache
        if let cachedImage = cache?[company] {
            completion(.value(company: company, image: cachedImage))
        } else {
            ImageManager.image(forURL: company.imageURL, completion: { response in
                guard let imageInfo = response.value else {
                    completion(.error)
                    return
                }

                let overlayColor = company.color.withAlphaComponent(0.5)
                guard let overlayedImage = imageInfo.image.image(withOverlayColor: overlayColor) else {
                    completion(.value(company: company, image: imageInfo.image))
                    return
                }
                
                cache?[company] = overlayedImage
                completion(.value(company: company, image: overlayedImage))
            })
        }
    }
}

