//
//  CompanyDetailsViewController.swift
//  PromoHunt
//
//  Created by David Elsonbaty on 3/4/17.
//  Copyright © 2017 David Elsonbaty. All rights reserved.
//

import UIKit
import Cletrol

class CompanyDetailsViewController: UIViewController {

    static let backButtonFadeAnimationDuration: TimeInterval = 0.5
    static let companyDetailsViewMaxSizeRatio: CGFloat = 150.0/375.0
    static let companyDetailsViewMinSizeRatio: CGFloat = 58.0/375.0

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var newCodeButton: UIButton!
    @IBOutlet weak var companyDetailsViewContainer: UIView!
    @IBOutlet weak var companyDetailsViewHeight: NSLayoutConstraint!
    @IBOutlet weak var promosContainerView: UIView!
    
    var companyDetailsView: CompanyDetailsView!
    var companyDetailsViewMaxHeight: CGFloat = 0.0
    var companyDetailsViewMinHeight: CGFloat = 0.0
    var promosViewController: DelegationViewController<PromosCoordinator>!

    var company: Company
    init(company: Company) {
        self.company = company
        super.init(nibName: CompanyDetailsViewController.classIdentifier, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        backButton.alpha = 0
        view.backgroundColor = AppColors.lightGrey
        newCodeButton.backgroundColor = AppColors.green

        companyDetailsView = CompanyDetailsView.instanceFromNib()
        companyDetailsViewContainer.addSubview(companyDetailsView)
        companyDetailsView.snp.makeConstraints { maker in
            maker.edges.equalTo(companyDetailsViewContainer)
        }

        let promosCoordinator = PromosCoordinator(company: company)
        promosCoordinator.promosViewControllerDelegate = self
        promosViewController = DelegationViewController(coordinator: promosCoordinator)
        addChildViewControllerWithView(promosViewController, andPintoView: promosContainerView)
    }

    @IBAction func didTapBackButton(_ sender: Any) {
        navigationController?.pop(animated: true)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        companyDetailsViewMinHeight = view.frame.width * CompanyDetailsViewController.companyDetailsViewMinSizeRatio
        companyDetailsViewMaxHeight = view.frame.width * CompanyDetailsViewController.companyDetailsViewMaxSizeRatio
    }

    func setupCompanyDetailsViewHeight(with scrollView: UIScrollView) {

        print(scrollView.contentOffset.y)
        let companyDetailsViewHeightDifference = companyDetailsViewMaxHeight - scrollView.contentOffset.y
        let computedHeight = min(max(companyDetailsViewHeightDifference, companyDetailsViewMinHeight), companyDetailsViewMaxHeight)
        companyDetailsViewHeight.constant = computedHeight

        let openRange = companyDetailsViewMaxHeight - companyDetailsViewMinHeight
        let openPercentage = computedHeight.subtracting(companyDetailsViewMinHeight).divided(by: openRange)
        companyDetailsView.nameLabelVerticalOffset.constant = (1 - openPercentage) * 20.0
    }
}

extension CompanyDetailsViewController: ZoomTransitionProtocol {

    func viewForTransition() -> UIView {
        return companyDetailsView
    }

    func didCompleteTransition(fromView: UIView) {
        guard let fromCompanyDetailsView = fromView as? CompanyDetailsView else { return }

        companyDetailsView.company = fromCompanyDetailsView.company
        UIView.animate(withDuration: CompanyDetailsViewController.backButtonFadeAnimationDuration) {
            self.backButton.alpha = 1.0
        }
    }
}

extension CompanyDetailsViewController: PromosViewControllerDelegate {

    func promosViewController(_ viewController: PromosViewController, didScrollWithScrollView scrollView: UIScrollView) {
        setupCompanyDetailsViewHeight(with: scrollView)
    }
}
