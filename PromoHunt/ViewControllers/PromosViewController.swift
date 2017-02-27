//
//  PromosViewController.swift
//  PromoHunt
//
//  Created by David Elsonbaty on 2/5/17.
//  Copyright © 2017 David Elsonbaty. All rights reserved.
//

import UIKit
import SnapKit

class PromosViewController: UIViewController {

    static let backButtonFadeAnimationDuration: TimeInterval = 0.5
    static let companyDetailsViewMaxSizeRatio: CGFloat = 150.0/375.0
    static let companyDetailsViewMinSizeRatio: CGFloat = 58.0/375.0

    @IBOutlet weak var backButon: UIButton!
    @IBOutlet weak var newCodeButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var companyDetailsViewContainer: UIView!
    @IBOutlet weak var companyDetailsViewHeight: NSLayoutConstraint!
    
    var companyDetailsView: CompanyDetailsView!
    var companyDetailsViewMaxHeight: CGFloat = 0.0
    var companyDetailsViewMinHeight: CGFloat = 0.0
    
    var company: Company?
    var promos: [Promo]? {
        didSet {
            tableView.reloadData()
            tableView.isUserInteractionEnabled = (promos != nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        backButon.alpha = 0
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = AppColors.lightGrey
        tableView.backgroundColor = AppColors.lightGrey
        tableView.isUserInteractionEnabled = false
        
        tableView.register(reusableCellWithClass: PromoTableViewCell.self)
        tableView.register(reusableCellWithClass: PromoLoadingTableViewCell.self)
        
        view.backgroundColor = AppColors.lightGrey
        newCodeButton.backgroundColor = AppColors.green
        
        companyDetailsView = CompanyDetailsView.instanceFromNib()
        companyDetailsViewContainer.addSubview(companyDetailsView)
        companyDetailsView.snp.makeConstraints { maker in
            maker.edges.equalTo(companyDetailsViewContainer)
        }
        
        fetchPromosArray()
    }
    
    @IBAction func didTapBackButton(_ sender: Any) {
        navigationController?.pop(animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        companyDetailsViewMinHeight = view.frame.width * PromosViewController.companyDetailsViewMinSizeRatio
        companyDetailsViewMaxHeight = view.frame.width * PromosViewController.companyDetailsViewMaxSizeRatio
        
        setupCompanyDetailsViewHeight()
    }
    
    func fetchPromosArray() {
        guard let company = company else { fatalError() }
        
        promos = nil
        PromosFetchRequest.request(for: company) { response in
            guard let promos = response.value else { return }
            self.promos = promos
            
            while let currentPromos = self.promos, currentPromos.count < 20 {
                self.promos = currentPromos.appending(array: currentPromos)
            }
        }
    }
    
    func setupCompanyDetailsViewHeight() {
        
        let companyDetailsViewHeightDifference = companyDetailsViewMaxHeight - tableView.contentOffset.y
        let computedHeight = min(max(companyDetailsViewHeightDifference, companyDetailsViewMinHeight), companyDetailsViewMaxHeight)
        companyDetailsViewHeight.constant = computedHeight
        
        let openRange = companyDetailsViewMaxHeight - companyDetailsViewMinHeight
        let openPercentage = computedHeight.subtracting(companyDetailsViewMinHeight).divided(by: openRange)
        companyDetailsView.nameLabelVerticalOffset.constant = (1 - openPercentage) * 20.0
    }
}

extension PromosViewController: ZoomTransitionProtocol {
    
    func viewForTransition() -> UIView {
        return companyDetailsView
    }
    
    func didCompleteTransition(fromView: UIView) {
        guard let fromCompanyDetailsView = fromView as? CompanyDetailsView else { return }

        companyDetailsView.company = fromCompanyDetailsView.company
        UIView.animate(withDuration: PromosViewController.backButtonFadeAnimationDuration) {
            self.backButon.alpha = 1.0
        }
    }
}   

extension PromosViewController: UITableViewDataSource {
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let promos = promos else {
            return Int(tableView.frame.height.divided(by: PromoTableViewCellSpec.cellHeight).rounded(.up))
        }
        return promos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let promos = promos else { return tableView.dequeue(reusableCellWithClass: PromoLoadingTableViewCell.self, for: indexPath) }
        
        let promo = promos[indexPath.item]
        return tableView.dequeue(reusableCellWithClass: PromoTableViewCell.self, for: indexPath) { cell in
            cell.labelView.text = promo.code.uppercased()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return PromoTableViewCellSpec.cellHeight
    }
}

extension PromosViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        setupCompanyDetailsViewHeight()
    }
}

