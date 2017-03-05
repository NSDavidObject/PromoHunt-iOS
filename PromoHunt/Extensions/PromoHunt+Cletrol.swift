//
//  PromoHunt+Cletrol.swift
//  PromoHunt
//
//  Created by David Elsonbaty on 2/24/17.
//  Copyright © 2017 David Elsonbaty. All rights reserved.
//

import UIKit
import CommonUtilities
import Cletrol

extension UIViewController {

    public class func instance(by coordinator: AnyObject) -> Self {
        return controllerFromNib()
    }
    public var presentedView: UIView! {
        return view
    }
}

extension DelegationViewController: ZoomTransitionProtocol {
    
    public func viewForTransition() -> UIView {
        guard let conformingController = presentedPresenter as? ZoomTransitionProtocol else { fatalError() }
        return conformingController.viewForTransition()
    }
    
    public func didCompleteTransition(fromView: UIView) {
        guard let conformingController = presentedPresenter as? ZoomTransitionProtocol else { return }
        return conformingController.didCompleteTransition(fromView: fromView)
    }
}
