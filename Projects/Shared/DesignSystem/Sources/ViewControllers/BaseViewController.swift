//
//  BaseViewController.swift
//  SharedDesignSystem
//
//  Created by 지연 on 8/28/24.
//

import UIKit
import PinLayout

// MARK: - Protocols

public protocol NavigationBarConfigurable {
    func setBackButton()
    func setRightButton(title: String, action: Selector)
    func setRightButton(imageString: String, action: Selector)
    func setTitle(_ title: String?)
    func setLargeTitle(_ title: String?, _ color: UIColor?)
    func setSubTitle(_ title: String?, _ color: UIColor?)
}

protocol ViewControllerConfigurable {
    func setBackgroundColor(_ color: UIColor)
}

// MARK: - BaseViewController

open class BaseViewController<View: UIView>: UIViewController, NavigationBarConfigurable, ViewControllerConfigurable {
    private let navigationBar = UIView()
    public let contentView = View()

    private lazy var backButton: UIButton = createBackButton()
    private lazy var rightButton: UIButton = createRightButton()
    private lazy var titleLabel: UILabel = createTitleLabel()
    private lazy var largeTitleLabel: UILabel = createLargeTitleLabel()
    private lazy var subtitleLabel: UILabel = createSubtitleLabel()

    // MARK: - Life Cycle

    open override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewController()
    }

    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setupLayout()
    }

    // MARK: - Setup Methods

    private func setupViewController() {
        navigationController?.setNavigationBarHidden(true, animated: false)
        view.backgroundColor = Colors.background
        
        [navigationBar, contentView]
            .forEach { view.addSubview($0) }
        [backButton, rightButton, titleLabel, largeTitleLabel, subtitleLabel]
            .forEach { navigationBar.addSubview($0) }
    }

    private func setupLayout() {
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

    // MARK: - NavigationBarConfigurable

    public func setBackButton() {
        backButton.isHidden = false
        backButton.addTarget(self, action: #selector(handleBackButtonTap), for: .touchUpInside)
    }

    public func setRightButton(title: String, action: Selector) {
        var attributedTitle = AttributedString(title)
        attributedTitle.font = Fonts.regular(size: 16.0)
        rightButton.configuration?.attributedTitle = attributedTitle
        rightButton.addTarget(self, action: action, for: .touchUpInside)
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

    public func setLargeTitle(_ title: String?, _ color: UIColor? = Colors.gray08) {
        largeTitleLabel.text = title
        largeTitleLabel.textColor = color
    }

    public func setSubTitle(_ title: String?, _ color: UIColor? = Colors.gray08) {
        subtitleLabel.text = title
        subtitleLabel.textColor = color
    }

    // MARK: - ViewControllerConfigurable

    public func setBackgroundColor(_ color: UIColor) {
        view.backgroundColor = color
    }

    // MARK: - Private Methods

    @objc private func handleBackButtonTap() {
        navigationController?.popViewController(animated: true)
    }

    private func createBackButton() -> UIButton {
        let button = UIButton()
        button.tintColor = Colors.gray08
        button.configuration = .plain()
        button.configuration?.image = UIImage(
            systemName: "chevron.left",
            withConfiguration: UIImage.SymbolConfiguration(pointSize: 15.0, weight: .medium)
        )
        button.isHidden = true
        return button
    }

    private func createRightButton() -> UIButton {
        let button = UIButton()
        button.tintColor = Colors.gray08
        button.configuration = .plain()
        return button
    }

    private func createTitleLabel() -> UILabel {
        let label = UILabel()
        label.textColor = Colors.gray08
        label.font = Fonts.bold(size: 16.0)
        return label
    }

    private func createLargeTitleLabel() -> UILabel {
        let label = UILabel()
        label.font = Fonts.bold(size: 24.0)
        label.numberOfLines = 0
        return label
    }

    private func createSubtitleLabel() -> UILabel {
        let label = UILabel()
        label.font = Fonts.semiBold(size: 13.5)
        return label
    }
}
