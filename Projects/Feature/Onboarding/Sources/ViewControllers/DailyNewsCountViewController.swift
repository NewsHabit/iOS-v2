//
//  DailyNewsCountViewController.swift
//  FeatureOnboarding
//
//  Created by 지연 on 8/29/24.
//

import UIKit

import FeatureOnboardingInterface
import Shared

public final class DailyNewsCountViewController:BaseViewController<DailyNewsCountView> {
    public weak var delegate: DailyNewsCountViewControllerDelegate?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDelegate()
        setupAction()
    }
    
    private func setupDelegate() {
        dailyNewsCountTableView.dataSource = self
    }
    
    private func setupAction() {
        doneButton.addTarget(self, action: #selector(handleDoneButtonTap), for: .touchUpInside)
    }
    
    @objc private func handleDoneButtonTap() {
        delegate?.dailyNewsCountViewControllerDidFinish()
    }
}

extension DailyNewsCountViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DailyNewsCountType.allCases.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: DailyNewsCountCell.self)
        cell.configure(with: DailyNewsCountType.allCases[indexPath.row].rawValue)
        cell.setSelected(true)
        return cell
    }
}

private extension DailyNewsCountViewController {
    var dailyNewsCountTableView: UITableView {
        contentView.tableView
    }
    
    var doneButton: NewsHabitConfirmButton {
        contentView.doneButton
    }
}
