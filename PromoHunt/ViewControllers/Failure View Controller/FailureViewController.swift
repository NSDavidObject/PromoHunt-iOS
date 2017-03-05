//
//  FailureViewController.swift
//  PromoHunt
//
//  Created by David Elsonbaty on 2/24/17.
//  Copyright © 2017 David Elsonbaty. All rights reserved.
//

import UIKit
import CommonUtilities
import Cletrol

class FailureViewController: UIViewController, FailurePresenter {

    @IBOutlet weak var errorMessageLabel: UILabel!
    @IBOutlet weak var retryButton: UIButton!

    weak var delegationController: UIViewController?
    weak var delegate: FailurePresenterDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = AppColors.lightGrey
        
        errorMessageLabel.text = NSLocalizedString("Oh no, there’s a problem with your request. Wanna try again?", comment: "Oh no, there’s with your request. Wanna try again?")
        errorMessageLabel.textColor = AppColors.textGrey

        retryButton.layer.borderWidth = 1.0
        retryButton.layer.borderColor = AppColors.textGrey.cgColor
        retryButton.setTitleColor(AppColors.textGrey, for: .normal)
        retryButton.setTitle(NSLocalizedString("Retry", comment: "Retry"), for: .normal)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        retryButton.layer.cornerRadius = ProportionalCornerRadius.circular.cornerRadius(forSize: retryButton.frame.size)
    }
    
    @IBAction func didTapRetryButton(_ sender: Any) {
        delegate?.failureDataViewControllerDidRetry(self)
    }
    
    public func setup(with: Any, numberOfTries: Int) {
        
    }
}
