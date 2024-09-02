//
//  DailyNewsCountViewController.swift
//  FeatureMain
//
//  Created by 지연 on 9/3/24.
//

import UIKit

import Shared

public final class DailyNewsCountViewController: BottomSheetViewController<DailyNewsCountView> {
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDelegate()
    }
    
    private func setupDelegate() {
        dailyNewsCountTableView.dataSource = self
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
        bottomSheetView.tableView
    }
    
    var saveButton: NewsHabitConfirmButton {
        bottomSheetView.saveButton
    }
}
