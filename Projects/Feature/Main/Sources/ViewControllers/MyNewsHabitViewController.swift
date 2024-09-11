//
//  MyNewsHabitViewController.swift
//  FeatureMain
//
//  Created by 지연 on 9/2/24.
//

import UIKit

import Core
import Shared

public final class MyNewsHabitViewController: BaseViewController<MyNewsHabitView> {
    private let localStorageService: LocalStorageProtocol
    private let viewFactory: MyNewsHabitViewFactory
    
    // MARK: - Init
    
    public init(localStorageService: LocalStorageProtocol, viewFactory: MyNewsHabitViewFactory) {
        self.localStorageService = localStorageService
        self.viewFactory = viewFactory
        
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupDelegate()
        setupObserver()
    }
    
    private func setupNavigationBar() {
        setBackButton()
        setTitle("나의 뉴빗")
    }
    
    private func setupDelegate() {
        contentView.delegate = self
        contentView.dataSource = self
    }
    
    private func setupObserver() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleMyNewsHabitDataDidChange),
            name: .MyNewsHabitDataDidChangeNotification,
            object: nil
        )
    }
    
    @objc private func handleMyNewsHabitDataDidChange() {
        contentView.reloadData()
    }
}

extension MyNewsHabitViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        present(viewController(for: MyNewsHabitType.allCases[indexPath.row]), animated: false)
    }
    
    private func viewController(for myNewsHabitType: MyNewsHabitType) -> UIViewController {
        switch myNewsHabitType {
        case .category:         return viewFactory.makeCategoryViewController()
        case .dailyNewsCount:   return viewFactory.makeDailyNewsCountViewController()
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
        let type = MyNewsHabitType.allCases[indexPath.row]
        cell.configure(title: type.title, description: description(for: type))
        return cell
    }
    
    private func description(for type: MyNewsHabitType) -> String {
        switch type {
        case .category:
            let categories = localStorageService.userSettings.selectedCategories
            return categories.count > 1 ?
            "\(categories[0].name) 외 \(categories.count - 1)개" :
            categories[0].name
        case .dailyNewsCount:
            let count = localStorageService.userSettings.dailyNewsCount
            return "\(count.rawValue)개"
        }
    }
}
