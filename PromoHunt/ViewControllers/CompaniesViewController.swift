//
//  CompaniesViewController.swift
//  PromoHunt
//
//  Created by David Elsonbaty on 2/5/17.
//  Copyright © 2017 David Elsonbaty. All rights reserved.
//

import UIKit
import CommonUtilities

class CompaniesViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!

    var companies = [Company]() {
        didSet {
            collectionView.reloadData()
            collectionView.isScrollEnabled = (companies.count > 0)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isScrollEnabled = false
        collectionView.register(reusableCellWithClass: CompanyCollectionViewCell.self)
        collectionView.register(reusableCellWithClass: CompanyLoadingCollectionViewCell.self)

        fetchCompaniesArray()
    }

    func fetchCompaniesArray() {
        companies = []
        collectionView.isScrollEnabled = false
        CompaniesFetchRequest.request { response in
            guard let companies = response.value else { return }
            self.companies = companies
        }
    }
}

extension CompaniesViewController: UICollectionViewDataSource {

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return companies.count > 0 ? companies.count : CompanyLoadingCollectionViewCellSpec.numberOfCells(in: collectionView)
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard companies.count > 0 else {
            return collectionView.dequeue(reusableCellWithClass: CompanyLoadingCollectionViewCell.self, for: indexPath, customization: {
                $0.backgroundColor = CompanyLoadingCollectionViewCellSpec.backgroundColor(at: indexPath)
            })
        }
        
        let company = companies[indexPath.item]
        return collectionView.dequeue(reusableCellWithClass: CompanyCollectionViewCell.self, for: indexPath, customization: { cell in
            cell.company = company
            cell.companyNameLabel.text = company.name
            cell.companyColorView.backgroundColor = company.color.withAlphaComponent(0.5)
            cell.backgroundColor = CompanyLoadingCollectionViewCellSpec.backgroundColor(at: indexPath)
            
            ImageManager.image(forURL: company.imageURL, completion: { response in
                guard let imageInfo = response.value, let currentCompany = cell.company, currentCompany.imageURL == imageInfo.url else { return }
                cell.companyImageView.image = imageInfo.image
            })
        })
    }
}

extension CompaniesViewController: UICollectionViewDelegate {

    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

extension CompaniesViewController: UICollectionViewDelegateFlowLayout {

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = collectionView.frame.width.half
        return CGSize(width: cellWidth, height: cellWidth)
    }
}

