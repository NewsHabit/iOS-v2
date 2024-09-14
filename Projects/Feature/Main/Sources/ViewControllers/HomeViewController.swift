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
    private var dailyDataSource: UITableViewDiffableDataSource<Section, DailyNewsData>!
    private var monthlyDataSource: UICollectionViewDiffableDataSource<Section, MonthlyRecordData>!
    
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
        viewModel.send(.viewDidLoad)
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
        dailyDataSource = UITableViewDiffableDataSource<Section, DailyNewsData>(
            tableView: dailyNewsTableView
        ) { (tableView, indexPath, cellViewModel) -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(
                for: indexPath,
                cellType: DailyNewsCell.self
            )
            cell.configure(with: cellViewModel)
            return cell
        }
        
        monthlyDataSource = UICollectionViewDiffableDataSource<Section, MonthlyRecordData>(
            collectionView: monthlyRecordCollectionView
        ) { (collectionView, indexPath, cellViewModel) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(
                for: indexPath,
                cellType: MonthlyRecordCell.self
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
        
        viewModel.state.dailyNewsCellViewModels
            .sink { [weak self] cellViewModels in
                guard let self = self else { return }
                updateDailyDataSource(with: cellViewModels)
            }.store(in: &cancellables)
        
        viewModel.state.monthlyRecordCellViewModels
            .sink { [weak self] cellViewModels in
                guard let self = self else { return }
                updateMonthlyDataSource(with: cellViewModels)
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
    
    private func updateDailyDataSource(with cellViewModels: [DailyNewsData]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, DailyNewsData>()
        snapshot.appendSections([.main])
        snapshot.appendItems(cellViewModels)
        dailyDataSource.apply(snapshot, animatingDifferences: false)
    }
    
    private func updateMonthlyDataSource(with cellViewModels: [MonthlyRecordData]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, MonthlyRecordData>()
        snapshot.appendSections([.main])
        snapshot.appendItems(cellViewModels, toSection: .main)
        monthlyDataSource.apply(snapshot, animatingDifferences: false)
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
    
    var monthlyRecordCollectionView: UICollectionView {
        contentView.monthlyRecordView.collectionView
    }
}
