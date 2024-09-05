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
