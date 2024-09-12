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
    private let viewModel: HomeViewModel
    private var cancellables = Set<AnyCancellable>()
    private var dataSource: UITableViewDiffableDataSource<Section, DailyNewsCellViewModel>!
    
    // MARK: - Init
    
    public init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        
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
        setupDataSource()
        setupBinding()
    }
    
    // MARK: - Setup Methods
    
    private func setupDelegate() {
        dailyNewsTableView.delegate = self
    }
    
    private func setupNavigationBar() {
        setLargeTitle("사용자님의 뉴빗", Colors.gray01)
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
        viewModel.state.totalDaysAllNewsRead
            .sink { [weak self] totalDaysAllNewsRead in
                guard let self = self else { return }
                setSubTitle("👀 지금까지 \(totalDaysAllNewsRead)일 완독했어요!", Colors.gray01)
            }.store(in: &cancellables)
        
        viewModel.state.cellViewModels
            .sink { [weak self] cellViewModels in
                guard let self = self else { return }
                updateDataSource(with: cellViewModels)
            }.store(in: &cancellables)
        
        viewModel.state.selectedNewsURL
            .sink { [weak self] newsURL in
                guard let self = self, let url = newsURL else { return }
                navigationController?.pushViewController(
                    NewsViewController(url: url),
                    animated: true
                )
            }.store(in: &cancellables)
        
        viewModel.state.isTodayAllRead
            .sink { [weak self] isTodayAllRead in
                guard let self = self else { return }
                messageContainer.isHidden = !isTodayAllRead
                dailyNewsView.setNeedsLayout()
            }.store(in: &cancellables)
    }
    
    private func updateDataSource(with cellViewModels: [DailyNewsCellViewModel]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, DailyNewsCellViewModel>()
        snapshot.appendSections([.main])
        snapshot.appendItems(cellViewModels)
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}

extension HomeViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.send(.newsCellDidTap(index: indexPath.row))
    }
}

private extension HomeViewController {
    var dailyNewsView: DailyNewsView {
        contentView.dailyNewsView
    }
    
    var dailyNewsTableView: UITableView {
        contentView.dailyNewsView.tableView
    }
    
    var messageContainer: UIView {
        contentView.dailyNewsView.messageContainer
    }
}
