//
//  HomeViewController.swift
//  FeatureMainInterface
//
//  Created by 지연 on 8/29/24.
//

import Combine
import UIKit

import Shared

public final class HomeViewController: BaseViewController<HomeView> {
    private let dailyNewsViewModel: DailyNewsViewModel
    private var cancellables = Set<AnyCancellable>()
    private var dataSource: UITableViewDiffableDataSource<Section, DailyNewsCellViewModel>!
    
    // MARK: - Init
    
    public init(dailyNewsViewModel: DailyNewsViewModel) {
        self.dailyNewsViewModel = dailyNewsViewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupDataSource()
        setupBinding()
    }
    
    // MARK: - Setup Methods
    
    private func setupNavigationBar() {
        setLargeTitle("사용자님의 뉴빗", Colors.gray01)
        setSubTitle("👀 지금까지 0일 완독했어요!", Colors.gray01)
        setBackgroundColor(Colors.gray08)
    }
    
    private func setupDataSource() {
        dataSource = UITableViewDiffableDataSource<Section, DailyNewsCellViewModel>(
            tableView: dailyNewsTableView
        ) { (tableView, indexPath, cellViewModel) -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(
                for: indexPath,
                cellType: DailyNewsCell.self
            )
            cell.configure(with: cellViewModel)
            return cell
        }
    }
    
    private func setupBinding() {
        dailyNewsViewModel.state.cellViewModels
            .sink { [weak self] cellViewModels in
                guard let self = self else { return }
                updateDataSource(with: cellViewModels)
            }.store(in: &cancellables)
    }
    
    private func updateDataSource(with cellViewModels: [DailyNewsCellViewModel]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, DailyNewsCellViewModel>()
        snapshot.appendSections([.main])
        snapshot.appendItems(cellViewModels)
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}

private extension HomeViewController {
    var dailyNewsTableView: UITableView {
        contentView.dailyNewsView.tableView
    }
}
