//
//  CategoryViewController.swift
//  FeatureOnboarding
//
//  Created by 지연 on 8/29/24.
//

import UIKit

import FeatureOnboardingInterface
import Shared

public final class CategoryViewController: BaseViewController<CategoryView> {
    public weak var delegate: CategoryViewControllerDelegate?
    
    private let sizingLabel = {
        let label = UILabel()
        label.font = Fonts.regular(size: 14.0)
        return label
    }()
    
    // MARK: - Life Cycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupDelegate()
        setupAction()
    }
    
    private func setupNavigationBar() {
        setBackButton()
    }
    
    private func setupDelegate() {
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
    }
    
    private func setupAction() {
        nextButton.addTarget(self, action: #selector(handleNextButtonTap), for: .touchUpInside)
    }
    
    @objc private func handleNextButtonTap() {
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
        cell.configure(with: CategoryType.allCases[indexPath.row].name)
        cell.setSelected(false)
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
