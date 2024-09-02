//
//  MyNewsHabitViewController.swift
//  FeatureMain
//
//  Created by 지연 on 9/2/24.
//

import UIKit

import Shared

public final class MyNewsHabitViewController: BaseViewController<MyNewsHabitView> {
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupDelegate()
    }
    
    private func setupNavigationBar() {
        setBackButton()
        setTitle("나의 뉴빗")
    }
    
    private func setupDelegate() {
        contentView.delegate = self
        contentView.dataSource = self
    }
}

extension MyNewsHabitViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        present(viewController(for: MyNewsHabitType.allCases[indexPath.row]), animated: false)
    }
    
    private func viewController(for myNewsHabitType: MyNewsHabitType) -> UIViewController {
        switch myNewsHabitType {
        case .category:         return CategoryViewController(bottomSheetHeight: 400)
        case .todayNewsCount:   return TodayNewsCountViewController(bottomSheetHeight: 400)
        }
    }
}

extension MyNewsHabitViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MyNewsHabitType.allCases.count
    }
    
    public func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: MyNewsHabitCell.self)
        cell.configure(with: MyNewsHabitType.allCases[indexPath.row])
        return cell
    }
}
