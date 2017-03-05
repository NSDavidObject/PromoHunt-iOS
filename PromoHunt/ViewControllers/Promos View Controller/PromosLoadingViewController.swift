//
//  PromosLoadingViewController.swift
//  PromoHunt
//
//  Created by David Elsonbaty on 3/4/17.
//  Copyright © 2017 David Elsonbaty. All rights reserved.
//

import UIKit
import Cletrol

class PromosLoadingViewController: UIViewController, Presenter {

    @IBOutlet weak var tableView: UITableView!

    weak var delegationController: UIViewController?
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = AppColors.lightGrey

        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = AppColors.lightGrey
        tableView.backgroundColor = AppColors.lightGrey
        tableView.register(reusableCellWithClass: PromoLoadingTableViewCell.self)
    }
}

extension PromosLoadingViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return PromoTableViewCellSpec.cellHeight
    }
}

extension PromosLoadingViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Int(tableView.frame.height.divided(by: PromoTableViewCellSpec.cellHeight).rounded(.up))
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeue(reusableCellWithClass: PromoLoadingTableViewCell.self, for: indexPath)
    }
}
