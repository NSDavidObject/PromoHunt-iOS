//
//  CompaniesViewController.swift
//  PromoHunt
//
//  Created by David Elsonbaty on 2/5/17.
//  Copyright © 2017 David Elsonbaty. All rights reserved.
//

import UIKit
import CommonUtilities
import Cletrol

class CompaniesViewController: UIViewController, ContentPresenter {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var zoomTransition: ZoomTransition?
    var companies = [Company]() {
        didSet {
            collectionView.reloadData()
        }
    }

    weak var delegationController: UIViewController?
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(reusableCellWithClass: CompanyCollectionViewCell.self)
    }

    func setup(with result: Any?) {
        guard let requestResult = result as? RequestResult<[Company]> else { fatalError() }
        guard let companies = requestResult.value else { fatalError() }
        
        self.companies = companies
    }
}

extension CompaniesViewController: UICollectionViewDataSource {

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return companies.count
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        precondition(companies.count > indexPath.item)

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
        guard let navigationController = self.delegationController?.navigationController else { return }
        guard let company = companyCell.company else { return }

        zoomTransition = ZoomTransition(navigationController: navigationController)
        zoomTransition?.intialView = companyCell.companyDetailsView
        
        navigationController.delegate = zoomTransition

        let companyDetailsViewController = CompanyDetailsViewController(company: company)
        navigationController.pushViewController(companyDetailsViewController, animated: true)
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
