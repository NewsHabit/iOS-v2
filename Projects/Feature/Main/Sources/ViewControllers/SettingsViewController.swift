//
//  SettingsViewController.swift
//  FeatureMainInterface
//
//  Created by 지연 on 9/1/24.
//

import UIKit

import Shared

public final class SettingsViewController: BaseViewController<SettingsView> {
    private let viewFactory: SettingsViewFactory
    
    // MARK: - Init
    
    public init(viewFactory: SettingsViewFactory) {
        self.viewFactory = viewFactory
        
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        case .profile:      return viewFactory.makeProfileViewController()
        case .myNewsHabit:  return viewFactory.makeMyNewsHabitViewController()
        case .notification: return viewFactory.makeNotificationViewController()
        case .developer:    return viewFactory.makeDeveloperViewController()
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
