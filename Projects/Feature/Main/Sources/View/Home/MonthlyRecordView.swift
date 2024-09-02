//
//  MonthlyRecordView.swift
//  FeatureMain
//
//  Created by 지연 on 8/29/24.
//

import UIKit

import Shared

import PinLayout

public final class MonthlyRecordView: UIView {
    private var daysInCurrentMonth: Int {
        let calendar = Calendar.current
        let range = calendar.range(of: .day, in: .month, for: Date())!
        return range.count
    }
    
    private var firstWeekdayInCurrentMonth: Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month], from: Date())
        let startOfMonth = calendar.date(from: components)!
        return calendar.component(.weekday, from: startOfMonth)
    }
    
    // MARK: - Components
    
    private let titleLabel = {
        let label = UILabel()
        label.text = Date().formatAsFullYearMonth()
        label.font = Fonts.bold(size: 19.0)
        label.textColor = Colors.gray08
        return label
    }()
    
    lazy var collectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 25
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(cellType: MonthlyRecordCell.self)
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    // MARK: - Init
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        setupLayout()
    }
    
    private func setupView() {
        addSubview(titleLabel)
        addSubview(collectionView)
    }
    
    private func setupLayout() {
        titleLabel.pin
            .top(35)
            .hCenter()
            .sizeToFit()
        
        collectionView.pin
            .below(of: titleLabel)
            .marginTop(15)
            .horizontally()
            .bottom()
    }
}

extension MonthlyRecordView: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 30, bottom: 0, right: 30)
    }
    
    public func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout, 
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let itemsPerRow = 7
        let paddingSpace = 25 * (itemsPerRow - 1)
        let availableWidth = collectionView.frame.width - CGFloat(paddingSpace)
        let widthPerItem = availableWidth / CGFloat(itemsPerRow)
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
}

extension MonthlyRecordView: UICollectionViewDataSource {
    public func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        // 현재 달의 일수 + 시작 요일의 오프셋
        return daysInCurrentMonth + firstWeekdayInCurrentMonth - 1
    }
    
    public func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            for: indexPath,
            cellType: MonthlyRecordCell.self
        )
        let dayIndex = indexPath.row - (firstWeekdayInCurrentMonth - 1)
        if dayIndex >= 0 {
            let dayString = String(format: "%02d", dayIndex + 1)
            cell.configure(with: dayString)
        }
        return cell
    }
}
