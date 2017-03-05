//
//  CompaniesCoordinator.swift
//  PromoHunt
//
//  Created by David Elsonbaty on 2/24/17.
//  Copyright © 2017 David Elsonbaty. All rights reserved.
//

import Foundation
import Cletrol

class CompaniesCoordinator: PresentationCoordinator {
    typealias ResultType = RequestResult<[Company]>
    
    var contentControllerClass: ContentPresenter.Type = CompaniesViewController.self
    var loadingControllerClass: Presenter.Type? = CompaniesLoadingViewController.self
    var failureControllerClass: FailurePresenter.Type? = FailureViewController.self
    
    func loadData(completion: @escaping ((ResultType) -> Void)) {
        CompaniesFetchRequest.request(completion: completion)
    }
    
    func isFailure(_ result: ResultType) -> Bool {
        return result.value == nil
    }
}

