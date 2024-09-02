//
//  SettingsViewController.swift
//  FeatureMainInterface
//
//  Created by 지연 on 9/1/24.
//

import UIKit

import Shared

public final class SettingsViewController: BaseViewController<SettingsView> {
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupDelegate()
    }
    
    private func setupNavigationBar() {
        setLargeTitle("설정")
    }
    
    private func setupDelegate() {
        contentView.delegate = self
        contentView.dataSource = self
    }
}

extension SettingsViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.pushViewController(
            viewController(for: SettingsType.allCases[indexPath.row]),
            animated: true
        )
    }
    
    private func viewController(for settingsType: SettingsType) -> UIViewController {
        switch settingsType {
        case .profile:      return ProfileViewController()
        case .myNewsHabit:  return MyNewsHabitViewController()
        case .notification: return NotificationViewController()
        case .developer:    return ProfileViewController()
        }
    }
}

extension SettingsViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SettingsType.allCases.count
    }
    
    public func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: SettingsCell.self)
        cell.configure(with: SettingsType.allCases[indexPath.row])
        return cell
    }
}
