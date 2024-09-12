//
//  HotViewController.swift
//  FeatureMain
//
//  Created by 지연 on 8/30/24.
//

import Combine
import UIKit

import Domain
import Shared

public final class HotViewController: BaseViewController<HotView> {
    private let viewModel: HotNewsViewModel
    private var cancellables = Set<AnyCancellable>()
    private var dataSource: UITableViewDiffableDataSource<Section, HotNews>!
    
    // MARK: - Init
    
    public init(viewModel: HotNewsViewModel) {
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
        setupDataSource()
        setupBinding()
    }
    
    // MARK: - Setup Methods
    
    private func setupNavigationBar() {
        setLargeTitle("🔥 지금 뜨는 뉴스")
        setSubTitle("\(Date().formatAsFullDateTime()) 기준", Colors.gray04)
    }
    
    private func setupDataSource() {
        dataSource = UITableViewDiffableDataSource<Section, HotNews>(
            tableView: hotNewsTableView
        ) { (tableView, indexPath, cellViewModel) -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(
                for: indexPath,
                cellType: HotNewsCell.self
            )
            cell.configure(with: cellViewModel)
            return cell
        }
    }
    
    private func setupBinding() {
        viewModel.state.cellViewModels
            .sink { [weak self] cellViewModels in
                guard let self = self else { return }
                updateDataSource(with: cellViewModels)
            }.store(in: &cancellables)
    }
    
    private func updateDataSource(with cellViewModels: [HotNews]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, HotNews>()
        snapshot.appendSections([.main])
        snapshot.appendItems(cellViewModels)
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}

private extension HotViewController {
    var hotNewsTableView: UITableView {
        contentView.tableView
    }
}
