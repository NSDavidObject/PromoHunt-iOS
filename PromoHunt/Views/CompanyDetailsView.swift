//
//  CompanyDetailsView.swift
//  PromoHunt
//
//  Created by David Elsonbaty on 2/13/17.
//  Copyright © 2017 David Elsonbaty. All rights reserved.
//

import UIKit

class CompanyDetailsView: UIView {

    private static let ImageDownloadAnimationDuration = 0.5
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameLabelVerticalOffset: NSLayoutConstraint!
    
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
        CompanyOverlayedImageHelper.image(forCompany: company) { [weak self] cachableResponse in
            guard let imageInfo = cachableResponse.value, let strongSelf = self else { return }
            guard let currentCompany = strongSelf.company, currentCompany == imageInfo.company else { return }
            
            if !cachableResponse.fromCache {
                strongSelf.imageView.alpha = 0.0
                UIView.animate(withDuration: CompanyDetailsView.ImageDownloadAnimationDuration, animations: {
                    strongSelf.imageView.alpha = 1.0
                })
            }
            
            strongSelf.imageView.image = imageInfo.image
        }
    }
}

class OverlayedCompanyImageCache: MemoryCache<Company, UIImage> {
    static let shared = OverlayedCompanyImageCache()
}

class CompanyOverlayedImageHelper {
    
    static func image(forCompany company: Company, usingCache cacheUsability: CacheUsability<OverlayedCompanyImageCache> = .cache(OverlayedCompanyImageCache.shared), completion: @escaping ((CachableResult<(company: Company, image: UIImage)>) -> Void)) {
        
        let cache = cacheUsability.cache
        if let cachedImage = cache?[company] {
            completion(.memory(company: company, image: cachedImage))
        } else {
            ImageManager.image(forURL: company.imageURL, completion: { response in
                guard let imageInfo = response.value else {
                    completion(.error)
                    return
                }

                let overlayColor = company.color.withAlphaComponent(0.5)
                let dimOverlayColor = UIColor.black.withAlphaComponent(0.5)
                guard let overlayedImage = imageInfo.image.image(withOverlayColor: dimOverlayColor)?.image(withOverlayColor: overlayColor) else {
                    completion(.download(company: company, image: imageInfo.image))
                    return
                }
                
                cache?[company] = overlayedImage
                completion(.download(company: company, image: overlayedImage))
            })
        }
    }
}

