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
    private var indicatorCenterXConstraint: NSLayoutConstraint?
    
    // MARK: - Components
    
    private let flexContainer = UIView()
    
    private lazy var todayNewsLabel = createLabel(with: "오늘의 뉴스")
    
    private lazy var monthlyRecordLabel = createLabel(with: "이달의 기록")
    
    private let separator = {
        let view = UIView()
        view.backgroundColor = Colors.gray02
        return view
    }()
    
    private let indicator = {
        let view = UIView()
        view.backgroundColor = Colors.gray08
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let todayNewsView = TodayNewsView()
    
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
            
            flex.addItem(separator)
                .height(1)
                .marginTop(10)
            
            flex.addItem(todayNewsView)
                .grow(1)
        }
        
        addSubview(indicator)
        NSLayoutConstraint.activate([
            indicator.widthAnchor.constraint(equalTo: todayNewsLabel.widthAnchor),
            indicator.heightAnchor.constraint(equalToConstant: 3),
            indicator.centerYAnchor.constraint(equalTo: separator.centerYAnchor)
        ])
        indicatorCenterXConstraint = indicator.centerXAnchor.constraint(
            equalTo: todayNewsLabel.centerXAnchor
        )
        indicatorCenterXConstraint?.isActive = true
    }
    
    private func setupGestures() {
        let todayNewsTapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(todayNewsLabelTapped)
        )
        todayNewsLabel.addGestureRecognizer(todayNewsTapGesture)
        
        let monthlyRecordTapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(monthlyRecordLabelTapped)
        )
        monthlyRecordLabel.addGestureRecognizer(monthlyRecordTapGesture)
    }
    
    // MARK: - Actions
    
    @objc private func todayNewsLabelTapped() {
        moveIndicator(to: todayNewsLabel)
    }
    
    @objc private func monthlyRecordLabelTapped() {
        moveIndicator(to: monthlyRecordLabel)
    }
    
    private func moveIndicator(to label: UILabel) {
        indicatorCenterXConstraint?.isActive = false
        indicatorCenterXConstraint = indicator.centerXAnchor.constraint(
            equalTo: label.centerXAnchor
        )
        indicatorCenterXConstraint?.isActive = true
        
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
        }
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
