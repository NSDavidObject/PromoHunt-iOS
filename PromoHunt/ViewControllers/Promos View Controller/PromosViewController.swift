//
//  PromosViewController.swift
//  PromoHunt
//
//  Created by David Elsonbaty on 2/5/17.
//  Copyright © 2017 David Elsonbaty. All rights reserved.
//

import UIKit
import SnapKit
import Cletrol

protocol PromosViewControllerDelegate: class {
    func promosViewController(_ viewController: PromosViewController, didScrollWithScrollView scrollView: UIScrollView)
}

class PromosViewController: UIViewController, ContentPresenter {

    @IBOutlet weak var tableView: UITableView!

    weak var delegationController: UIViewController?
    weak var delegate: PromosViewControllerDelegate?

    var company: Company?
    var promos: [Promo]? {
        didSet {
            tableView.reloadData()
        }
    }

    override class func instance(by coordinator: AnyObject) -> Self {
        guard let coordinator = coordinator as? PromosCoordinator else { fatalError() }
        let controller = controllerFromNib()
        controller.company = coordinator.company
        controller.delegate = coordinator.promosViewControllerDelegate
        return controller
    }

    func setup(with result: Any?) {
        guard let requestResult = result as? RequestResult<[Promo]> else { fatalError() }
        guard let promos  = requestResult.value else { fatalError() }

        self.promos = promos
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = AppColors.lightGrey

        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = AppColors.lightGrey
        tableView.backgroundColor = AppColors.lightGrey
        tableView.register(reusableCellWithClass: PromoTableViewCell.self)
    }
}

extension PromosViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let promos = promos else { fatalError() }
        return promos.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let promo = promos?[indexPath.item] else { fatalError() }
        return tableView.dequeue(reusableCellWithClass: PromoTableViewCell.self, for: indexPath) { cell in
            cell.labelView.text = promo.code.uppercased()
            cell.selectionStyle = .none
        }
    }
}

extension PromosViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return PromoTableViewCellSpec.cellHeight
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.setSelected(false, animated: true)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        delegate?.promosViewController(self, didScrollWithScrollView: scrollView)
    }
}
