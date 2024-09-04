//
//  DailyNewsCountViewController.swift
//  FeatureOnboarding
//
//  Created by 지연 on 8/29/24.
//

import Combine
import UIKit

import FeatureOnboardingInterface
import Shared

public final class DailyNewsCountViewController:BaseViewController<DailyNewsCountView> {
    private let viewModel: DailyNewsCountViewModel
    private var cancellables = Set<AnyCancellable>()
    
    public weak var delegate: DailyNewsCountViewControllerDelegate?
    
    // MARK: - Init
    
    public init(viewModel: DailyNewsCountViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupDelegate()
        setupAction()
        setupBinding()
    }
    
    // MARK: - Setup Methods
    
    private func setupNavigationBar() {
        setBackButton()
    }
    
    private func setupDelegate() {
        dailyNewsCountTableView.delegate = self
        dailyNewsCountTableView.dataSource = self
    }
    
    private func setupAction() {
        doneButton.addTarget(self, action: #selector(handleDoneButtonTap), for: .touchUpInside)
    }
    
    private func setupBinding() {
        viewModel.$state
            .sink { [weak self] state in
                self?.dailyNewsCountTableView.reloadData()
            }.store(in: &cancellables)
    }
    
    // MARK: - Action Methods
    
    @objc private func handleDoneButtonTap() {
        viewModel.send(.doneButtonDidTap)
        delegate?.dailyNewsCountViewControllerDidFinish()
    }
}

extension DailyNewsCountViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedDailyNewsCount = DailyNewsCountType.dailyNewsCount(at: indexPath.row)
        viewModel.send(.dailyNewsCountDidSelect(count: selectedDailyNewsCount))
    }
}

extension DailyNewsCountViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DailyNewsCountType.allCases.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: DailyNewsCountCell.self)
        let dailyNewsCount = DailyNewsCountType.allCases[indexPath.row]
        cell.configure(
            with: dailyNewsCount.rawValue,
            isSelected: viewModel.state.count == dailyNewsCount
        )
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
