//
//  TodayNewsCountViewController.swift
//  FeatureOnboardingInterface
//
//  Created by 지연 on 8/29/24.
//

import UIKit

import Shared

public final class TodayNewsCountViewController:BaseViewController<TodayNewsCountView> {
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        todayNewsCountTableView.dataSource = self
    }
}

extension TodayNewsCountViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TodayNewsCount.allCases.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: TodayNewsCountCell.self)
        cell.configure(with: TodayNewsCount.allCases[indexPath.row].rawValue)
        cell.setSelected(true)
        return cell
    }
}

private extension TodayNewsCountViewController {
    var todayNewsCountTableView: UITableView {
        contentView.todayNewsCountTableView
    }
    
    var doneButton: NewsHabitConfirmButton {
        contentView.doneButton
    }
}
