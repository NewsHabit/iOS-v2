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
    private var dataSource: UITableViewDiffableDataSource<Section, DailyNewsCountCellViewModel>!
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
        
        setupDelegate()
        setupDataSource()
        setupAction()
        setupBinding()
    }
    
    // MARK: - Setup Methods
    
    private func setupDelegate() {
        dailyNewsCountTableView.delegate = self
    }
    
    private func setupDataSource() {
        dataSource = UITableViewDiffableDataSource<Section, DailyNewsCountCellViewModel>(
            tableView: dailyNewsCountTableView
        ) { (tableView, indexPath, cellViewModel) -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(
                for: indexPath,
                cellType: DailyNewsCountCell.self
            )
            cell.configure(with: cellViewModel)
            return cell
        }
    }
    
    private func setupAction() {
        doneButton.addTarget(self, action: #selector(handleDoneButtonTap), for: .touchUpInside)
    }
    
    private func setupBinding() {
        viewModel.state.cellViewModels
            .sink { [weak self] cellViewModels in
                guard let self = self else { return }
                updateDataSource(with: cellViewModels)
            }.store(in: &cancellables)
    }
    
    private func updateDataSource(with cellViewModels: [DailyNewsCountCellViewModel]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, DailyNewsCountCellViewModel>()
        snapshot.appendSections([.main])
        snapshot.appendItems(cellViewModels)
        dataSource.apply(snapshot, animatingDifferences: false)
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

private extension DailyNewsCountViewController {
    var dailyNewsCountTableView: UITableView {
        contentView.tableView
    }
    
    var doneButton: NewsHabitConfirmButton {
        contentView.doneButton
    }
}
