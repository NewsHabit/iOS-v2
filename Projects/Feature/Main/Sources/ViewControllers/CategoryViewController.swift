//
//  CategoryViewController.swift
//  FeatureMain
//
//  Created by 지연 on 9/3/24.
//

import Combine
import UIKit

import Shared

public final class CategoryViewController: BottomSheetViewController<CategoryView> {
    private let viewModel: CategoryViewModel
    private var cancellables = Set<AnyCancellable>()
    private var dataSource: UICollectionViewDiffableDataSource<Section, CategoryCellViewModel>!
    
    private let sizingLabel = {
        let label = UILabel()
        label.font = Fonts.regular(size: 14.0)
        return label
    }()
    
    // MARK: - Init
    
    public init(viewModel: CategoryViewModel) {
        self.viewModel = viewModel
        
        super.init()
    }
    
    @available(*, unavailable)
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
        categoryCollectionView.delegate = self
    }
    
    private func setupDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, CategoryCellViewModel>(
            collectionView: categoryCollectionView
        ) { (collectionView, indexPath, cellViewModel) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(
                for: indexPath,
                cellType: CategoryCell.self
            )
            cell.configure(with: cellViewModel)
            return cell
        }
    }
    
    private func setupAction() {
        saveButton.addTarget(self, action: #selector(handleNextButtonTap), for: .touchUpInside)
    }
    
    private func setupBinding() {
        viewModel.state.cellViewModels
            .sink { [weak self] cellViewModels in
                guard let self = self else { return }
                saveButton.isEnabled = !cellViewModels.filter{ $0.isSelected }.isEmpty
                updateDataSource(with: cellViewModels)
            }.store(in: &cancellables)
    }
    
    private func updateDataSource(with cellViewModels: [CategoryCellViewModel]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, CategoryCellViewModel>()
        snapshot.appendSections([.main])
        snapshot.appendItems(cellViewModels)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    // MARK: - Action Methods
    
    @objc private func handleNextButtonTap() {
        viewModel.send(.saveButtonDidTap)
        dismiss(animated: false)
    }
}

extension CategoryViewController: UICollectionViewDelegateFlowLayout {
    public func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        sizingLabel.text = CategoryType.allCases[indexPath.row].name
        
        var size = sizingLabel.sizeThatFits(.zero)
        size.width += 40
        size.height += 16
        
        return size
    }
}

extension CategoryViewController: UICollectionViewDelegate {
    public func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        guard let cellViewModel = dataSource.itemIdentifier(for: indexPath) else { return }
        viewModel.send(.categoryDidSelect(category: cellViewModel.category))
    }
}

private extension CategoryViewController {
    var categoryCollectionView: UICollectionView {
        bottomSheetView.collectionView
    }
    
    var saveButton: NewsHabitConfirmButton {
        bottomSheetView.saveButton
    }
}
