//
//  CompaniesLoadingViewController.swift
//  PromoHunt
//
//  Created by David Elsonbaty on 2/5/17.
//  Copyright © 2017 David Elsonbaty. All rights reserved.
//

import UIKit
import DataDelegator

class CompaniesLoadingViewController: UIViewController, Presenter {

    @IBOutlet weak var collectionView: UICollectionView!

    weak var delegationController: UIViewController?
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isScrollEnabled = false
        collectionView.register(reusableCellWithClass: CompanyLoadingCollectionViewCell.self)
    }
}

extension CompaniesLoadingViewController: UICollectionViewDataSource {

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return CompanyLoadingCollectionViewCellSpec.numberOfCells(in: collectionView)
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeue(reusableCellWithClass: CompanyLoadingCollectionViewCell.self, for: indexPath, customization: {
            $0.backgroundColor = CompanyLoadingCollectionViewCellSpec.backgroundColor(at: indexPath)
        })
    }
}

extension CompaniesLoadingViewController: UICollectionViewDelegateFlowLayout {

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = collectionView.frame.width.half
        return CGSize(width: cellWidth, height: cellWidth)
    }
}
