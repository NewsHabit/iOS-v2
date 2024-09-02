//
//  HomeView.swift
//  FeatureMainInterface
//
//  Created by 지연 on 8/29/24.
//

import UIKit

import Shared

import FlexLayout
import PinLayout

public final class HomeView: UIView {
    private enum HomeTab: Int {
        case todayNews
        case monthlyRecord
    }
    // MARK: - Components
    
    private let flexContainer = UIView()
    
    private lazy var todayNewsLabel = createLabel(with: "오늘의 뉴스")
    
    private lazy var monthlyRecordLabel = createLabel(with: "이달의 기록")
    
    private let separatorView = {
        let view = UIView()
        view.backgroundColor = Colors.gray02
        return view
    }()
    
    private let indicatorView = {
        let view = UIView()
        view.backgroundColor = Colors.gray08
        view.clipsToBounds = true
        view.layer.cornerRadius = 1
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let scrollView = {
        let view = UIScrollView()
        view.isPagingEnabled = true
        view.isScrollEnabled = false
        view.showsHorizontalScrollIndicator = false
        return view
    }()
    
    let todayNewsView = {
        let view = TodayNewsView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let monthlyRecordView = {
        let view = MonthlyRecordView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Init
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setupLayout()
        setupGestures()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        flexContainer.pin.all()
        flexContainer.flex.layout()
    }
    
    // MARK: - Setup Methods
    
    private func setupView() {
        backgroundColor = Colors.background
        clipsToBounds = true
        layer.cornerRadius = 30
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    private func setupLayout() {
        addSubview(flexContainer)
        flexContainer.flex.define { flex in
            flex.addItem()
                .gap(15)
                .direction(.row)
                .marginTop(40)
                .marginLeft(20)
                .define { flex in
                    flex.addItem(todayNewsLabel)
                    flex.addItem(monthlyRecordLabel)
                }
            
            flex.addItem(separatorView)
                .height(1)
                .marginTop(13)
            
            flex.addItem(scrollView)
                .marginTop(5)
                .grow(1)
        }
        
        addSubview(indicatorView)
        [todayNewsView, monthlyRecordView].forEach { scrollView.addSubview($0) }
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        let contentView = scrollView.contentLayoutGuide
        let frameView = scrollView.frameLayoutGuide
        
        NSLayoutConstraint.activate([
            indicatorView.widthAnchor.constraint(equalTo: todayNewsLabel.widthAnchor),
            indicatorView.heightAnchor.constraint(equalToConstant: 2),
            indicatorView.centerXAnchor.constraint(equalTo: todayNewsLabel.centerXAnchor),
            indicatorView.bottomAnchor.constraint(equalTo: separatorView.topAnchor),
            
            todayNewsView.widthAnchor.constraint(equalTo: frameView.widthAnchor),
            todayNewsView.heightAnchor.constraint(equalTo: frameView.heightAnchor),
            todayNewsView.topAnchor.constraint(equalTo: contentView.topAnchor),
            todayNewsView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            
            monthlyRecordView.widthAnchor.constraint(equalTo: frameView.widthAnchor),
            monthlyRecordView.heightAnchor.constraint(equalTo: frameView.heightAnchor),
            monthlyRecordView.topAnchor.constraint(equalTo: contentView.topAnchor),
            monthlyRecordView.leadingAnchor.constraint(equalTo: todayNewsView.trailingAnchor),
            monthlyRecordView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    
    private func setupGestures() {
        todayNewsLabel.addGestureRecognizer(UITapGestureRecognizer(
            target: self,
            action: #selector(handleTabLabelTap)
        ))
        monthlyRecordLabel.addGestureRecognizer(UITapGestureRecognizer(
            target: self,
            action: #selector(handleTabLabelTap)
        ))
    }
    
    // MARK: - Actions
    
    @objc private func handleTabLabelTap(_ gesture: UITapGestureRecognizer) {
        guard let tappedLabel = gesture.view as? UILabel else { return }
        updateTabUI(for: tappedLabel)
    }
    
    private func updateTabUI(for label: UILabel) {
        let selectedTab: HomeTab = label == todayNewsLabel ? .todayNews : .monthlyRecord
        let offset = CGPoint(x: CGFloat(selectedTab.rawValue) * scrollView.frame.width, y: 0)
        
        UIView.animate(withDuration: 0.3) {
            self.moveIndicator(to: label)
            self.scrollView.setContentOffset(offset, animated: false)
            self.layoutIfNeeded()
        }
    }
    
    private func moveIndicator(to label: UILabel) {
        indicatorView.center.x = label.convert(label.bounds, to: self).midX
    }
}

private extension HomeView {
    func createLabel(with text: String?) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = Fonts.bold(size: 18.0)
        label.textColor = Colors.gray08
        label.isUserInteractionEnabled = true
        return label
    }
}
