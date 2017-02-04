//
//  ViewController.swift
//  PromoHunt
//
//  Created by David Elsonbaty on 1/29/17.
//  Copyright © 2017 David Elsonbaty. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

//        CompaniesFetchRequest.request { companies in
//            guard let firstCompany = companies?.first else {
//                return
//            }
//            PromosFetchRequest.request(for: firstCompany, completion: { promos in
//                Swift.debugPrint(promos ?? "no response")
//                guard let lastPromo = promos?.last else {
//                    return
//                }
//                PromoVoteRequest.request(on: lastPromo, vote: .invalid, completion: { success in
//                    Swift.debugPrint(success ? "voted successfuly" : "vote failed")
//                })
//            })
//        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

