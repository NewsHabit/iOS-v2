//
//  BaseViewController.swift
//  SharedDesignSystem
//
//  Created by 지연 on 8/28/24.
//

import UIKit

import PinLayout

open class BaseViewController<View: UIView>: UIViewController {
    private let navigationBar = UIView()
    
    public let contentView = View()
    
    private lazy var backButton = {
        let button = UIButton()
        button.tintColor = .label
        button.configuration = .plain()
        button.configuration?.image = UIImage(
            systemName: "chevron.left",
            withConfiguration: UIImage.SymbolConfiguration(pointSize: 15.0, weight: .medium)
        )
        button.isHidden = true
        return button
    }()
    
    private lazy var rightButton = {
        let button = UIButton()
        button.tintColor = .label
        button.configuration = .plain()
        return button
    }()
    
    private lazy var titleLabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = Fonts.bold(size: 16.0)
        return label
    }()
    
    private lazy var largeTitleLabel = {
        let label = UILabel()
        label.font = Fonts.bold(size: 22.0)
        return label
    }()
    
    private lazy var subtitleLabel = {
        let label = UILabel()
        label.font = Fonts.semiBold(size: 13.5)
        return label
    }()
    
    // MARK: - Life Cycle
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        view.backgroundColor = Colors.background
        setupLayout()
    }
    
    private func setupLayout() {
        view.addSubview(navigationBar)
        navigationBar.addSubview(backButton)
        navigationBar.addSubview(rightButton)
        navigationBar.addSubview(titleLabel)
        navigationBar.addSubview(largeTitleLabel)
        navigationBar.addSubview(subtitleLabel)
        view.addSubview(contentView)
    }
    
    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        navigationBar.pin
            .top(view.safeAreaInsets.top)
            .horizontally()
        
        titleLabel.pin
            .top(15)
            .hCenter()
            .sizeToFit()
        
        backButton.pin
            .left(20)
            .vCenter(to: titleLabel.edge.vCenter)
            .sizeToFit()
        
        rightButton.pin
            .right(20)
            .vCenter(to: titleLabel.edge.vCenter)
            .sizeToFit()
        
        largeTitleLabel.pin
            .top(30)
            .left(20)
            .sizeToFit()
        
        subtitleLabel.pin
            .top(to: largeTitleLabel.edge.bottom).marginTop(5)
            .left(20)
            .sizeToFit()
        
        navigationBar.pin
            .height(subtitleLabel.frame.maxY + 15)
        
        contentView.pin
            .below(of: navigationBar)
            .horizontally()
            .bottom()
    }
    
    // MARK: - Setup Methods
    
    public func setBackButton() {
        backButton.isHidden = false
        backButton.addTarget(self, action: #selector(handleBackButtonTap), for: .touchUpInside)
    }
    
    @objc private func handleBackButtonTap() {
        navigationController?.popViewController(animated: true)
    }
    
    public func setRightButton(title: String) {
        var attributedTitle = AttributedString(title)
        attributedTitle.font = Fonts.regular(size: 16.0)
        rightButton.configuration?.attributedTitle = attributedTitle
    }
    
    public func setRightButton(imageString: String, action: Selector) {
        rightButton.configuration?.image = UIImage(
            systemName: imageString,
            withConfiguration: UIImage.SymbolConfiguration(pointSize: 15.0, weight: .medium)
        )
        rightButton.addTarget(self, action: action, for: .touchUpInside)
    }
    
    public func setTitle(_ title: String?) {
        titleLabel.text = title
    }
    
    public func setLargeTitle(_ title: String?, _ color: UIColor? = .label) {
        largeTitleLabel.text = title
        largeTitleLabel.textColor = color
    }
    
    public func setSubTitle(_ title: String?, _ color: UIColor? = .label) {
        subtitleLabel.text = title
        subtitleLabel.textColor = color
    }
}
