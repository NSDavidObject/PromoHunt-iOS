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
    
    var zoomTransition: ZoomTransition?
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
        precondition(companies.count == 0 || companies.count > indexPath.item)
        
        if companies.count == 0 {
            return collectionView.dequeue(reusableCellWithClass: CompanyLoadingCollectionViewCell.self, for: indexPath, customization: {
                $0.backgroundColor = CompanyLoadingCollectionViewCellSpec.backgroundColor(at: indexPath)
            })
        }
        
        let company = companies[indexPath.item]
        return collectionView.dequeue(reusableCellWithClass: CompanyCollectionViewCell.self, for: indexPath, customization: { cell in
            cell.company = company
            cell.companyDetailsView.company = company
            cell.backgroundColor = CompanyLoadingCollectionViewCellSpec.backgroundColor(at: indexPath)
        })
    }
}

extension CompaniesViewController: UICollectionViewDelegate {

    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard companies.count > indexPath.item else { return }
        guard let companyCell = collectionView.cellForItem(at: indexPath) as? CompanyCollectionViewCell else { return }
        guard let navigationController = navigationController else { return }
        
//        let company = companies[indexPath.item]
        
        let promosViewController = PromosViewController.controllerFromNib()
        promosViewController.company = companyCell.company
        
        if let navigationController = self.navigationController {
            zoomTransition = ZoomTransition(navigationController: navigationController)
            zoomTransition?.intialView = companyCell.companyDetailsView
        }
        
        navigationController.delegate = zoomTransition
        navigationController.pushViewController(promosViewController, animated: true)
    }
}

extension CompaniesViewController: UICollectionViewDelegateFlowLayout {

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = collectionView.frame.width.half
        return CGSize(width: cellWidth, height: cellWidth)
    }
}

extension CompaniesViewController: ZoomTransitionProtocol {
    
    func viewForTransition() -> UIView {
        return zoomTransition!.intialView!
    }
    
    func didCompleteTransition(fromView: UIView) {
        
    }
}

