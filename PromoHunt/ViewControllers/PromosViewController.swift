//
//  PromosViewController.swift
//  PromoHunt
//
//  Created by David Elsonbaty on 2/5/17.
//  Copyright © 2017 David Elsonbaty. All rights reserved.
//

import UIKit

class PromosViewController: UIViewController {

    @IBOutlet weak var companyDetailsViewContainer: UIView!
    var companyDetailsView: CompanyDetailsView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        companyDetailsView = CompanyDetailsView.instanceFromNib()
        companyDetailsViewContainer.addSubview(companyDetailsView)
        companyDetailsView.snp.makeConstraints { maker in
            maker.edges.equalTo(companyDetailsViewContainer)
        }
    }
    
    @IBAction func didTapBackButton(_ sender: Any) {
        navigationController?.pop(animated: true)
    }
}

extension PromosViewController: ZoomTransitionProtocol {
    
    func viewForTransition() -> UIView {
        return companyDetailsView
    }
    
    func didCompleteTransition(fromView: UIView) {
        guard let fromCompanyDetailsView = fromView as? CompanyDetailsView else { return }
        companyDetailsView.company = fromCompanyDetailsView.company
    }
}   
