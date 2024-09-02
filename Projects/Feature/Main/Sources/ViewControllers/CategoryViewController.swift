//
//  CategoryViewController.swift
//  FeatureMain
//
//  Created by 지연 on 9/3/24.
//

import UIKit

import Shared

public final class CategoryViewController: BottomSheetViewController<CategoryView> {
    private let sizingLabel = {
        let label = UILabel()
        label.font = Fonts.regular(size: 14.0)
        return label
    }()
    
    // MARK: - Life Cycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDelegate()
    }
    
    private func setupDelegate() {
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
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
        bottomSheetView.collectionView
    }
    
    var saveButton: NewsHabitConfirmButton {
        bottomSheetView.saveButton
    }
}
