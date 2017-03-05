//
//  PromosCoordinator.swift
//  PromoHunt
//
//  Created by David Elsonbaty on 2/24/17.
//  Copyright © 2017 David Elsonbaty. All rights reserved.
//

import Foundation
import Cletrol

class PromosCoordinator: PresentationCoordinator {
    typealias ResultType = RequestResult<[Promo]>

    var contentControllerClass: ContentPresenter.Type = PromosViewController.self
    var loadingControllerClass: Presenter.Type? = PromosLoadingViewController.self
    var failureControllerClass: FailurePresenter.Type? = FailureViewController.self

    let company: Company
    var promosViewControllerDelegate: PromosViewControllerDelegate?
    init(company: Company) {
        self.company = company
    }

    func loadData(completion: @escaping ((ResultType) -> Void)) {
        PromosFetchRequest.request(for: company, completion: completion)
    }
    
    func isFailure(_ result: ResultType) -> Bool {
        return result.value == nil
    }
}

