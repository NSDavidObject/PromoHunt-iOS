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
        collectionView.register(LoadingCompanyCollectionViewCell.nib(), forCellWithReuseIdentifier: LoadingCompanyCollectionViewCell.reuseIdentifier)

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
        return companies.count > 0 ? companies.count : CompanyLoadingCellSpec.numberOfCells(in: collectionView)
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeue(reusableCellWithClass: LoadingCompanyCollectionViewCell.self, for: indexPath)
        cell.backgroundColor = CompanyLoadingCellSpec.backgroundColor(at: indexPath)
        return cell
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


