//
//  CompaniesCoordinator.swift
//  PromoHunt
//
//  Created by David Elsonbaty on 2/24/17.
//  Copyright © 2017 David Elsonbaty. All rights reserved.
//

import Foundation
import DataDelegator

class CompaniesCoordinator: DataPresenterCoordinator {
    typealias ResultType = RequestResult<[Company]>
    
    var contentControllerClass: ContentDataPresenter.Type = CompaniesViewController.self
    var loadingControllerClass: DataPresenter.Type? = CompaniesLoadingViewController.self
    var failureControllerClass: FailureDataPresenter.Type? = FailureViewController.self
    
    func loadData(completion: @escaping ((ResultType) -> Void)) {
        CompaniesFetchRequest.request(completion: completion)
    }
    
    func isFailure(_ result: ResultType) -> Bool {
        return result.value == nil
    }
}

