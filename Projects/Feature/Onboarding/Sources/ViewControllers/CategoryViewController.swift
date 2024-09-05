//
//  CategoryViewController.swift
//  FeatureOnboarding
//
//  Created by 지연 on 8/29/24.
//

import Combine
import UIKit

import FeatureOnboardingInterface
import Shared

public final class CategoryViewController: BaseViewController<CategoryView> {
    private let viewModel: CategoryViewModel
    private var cancellables = Set<AnyCancellable>()
    
    public weak var delegate: CategoryViewControllerDelegate?
    
    /// CategoryCell의 크기를 동적으로 알아내기 위한 더미 셀
    private let sizingLabel = {
        let label = UILabel()
        label.font = Fonts.regular(size: 14.0)
        return label
    }()
    
    // MARK: - Init
    
    public init(viewModel: CategoryViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDelegate()
        setupAction()
        setupBinding()
    }
    
    // MARK: - Setup Methods
    
    private func setupDelegate() {
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
    }
    
    private func setupAction() {
        nextButton.addTarget(self, action: #selector(handleNextButtonTap), for: .touchUpInside)
    }
    
    private func setupBinding() {
        viewModel.$state
            .sink { [weak self] state in
                guard let self else { return }
                nextButton.isEnabled = !state.categories.isEmpty
                categoryCollectionView.reloadData()
            }.store(in: &cancellables)
    }
    
    // MARK: - Action Methods
    
    @objc private func handleNextButtonTap() {
        viewModel.send(.nextButtonDidTap)
        delegate?.categoryViewControllerDidFinish()
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
        let selectedCategory = CategoryType.category(at: indexPath.row)
        viewModel.send(.categoryDidSelect(category: selectedCategory))
    }
}

extension CategoryViewController: UICollectionViewDataSource {
    public func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return CategoryType.allCases.count
    }
    
    public func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: CategoryCell.self)
        let category = CategoryType.allCases[indexPath.row]
        cell.configure(
            with: category.name,
            isSelected: viewModel.state.categories.contains(category)
        )
        return cell
    }
}

private extension CategoryViewController {
    var categoryCollectionView: UICollectionView {
        contentView.collectionView
    }
    
    var nextButton: NewsHabitConfirmButton {
        contentView.nextButton
    }
}
