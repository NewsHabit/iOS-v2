//
//  TodayNewsCountViewController.swift
//  FeatureMain
//
//  Created by 지연 on 9/3/24.
//

import UIKit

import Shared

public final class TodayNewsCountViewController: BottomSheetViewController<TodayNewsCountView> {
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDelegate()
    }
    
    private func setupDelegate() {
        todayNewsCountTableView.dataSource = self
    }
}

extension TodayNewsCountViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TodayNewsCountType.allCases.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: TodayNewsCountCell.self)
        cell.configure(with: TodayNewsCountType.allCases[indexPath.row].rawValue)
        cell.setSelected(true)
        return cell
    }
}

private extension TodayNewsCountViewController {
    var todayNewsCountTableView: UITableView {
        bottomSheetView.tableView
    }
    
    var saveButton: NewsHabitConfirmButton {
        bottomSheetView.saveButton
    }
}
