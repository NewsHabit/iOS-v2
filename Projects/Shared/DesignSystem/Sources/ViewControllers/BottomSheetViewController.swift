//
//  BottomSheetViewController.swift
//  SharedDesignSystem
//
//  Created by 지연 on 9/2/24.
//

import UIKit

open class BottomSheetViewController<View: UIView>: UIViewController {
    private var bottomSheetViewBottomConstraint: NSLayoutConstraint?
    private let bottomSheetHeight: CGFloat
    private let animationDuration = 0.3

    // MARK: - components

    private let dimmedView = {
        let view = UIView()
        view.backgroundColor = Colors.dim
        view.alpha = 0.0
        view.isUserInteractionEnabled = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    public let bottomSheetView: View = {
        let view = View()
        view.clipsToBounds = true
        view.layer.cornerRadius = 20
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let indicator = {
        let view = UIView()
        view.backgroundColor = Colors.gray02
        view.clipsToBounds = true
        view.layer.cornerRadius = 2
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // MARK: - init

    public init(
        bottomSheetHeight: CGFloat = 400.0,
        modalPresentationStyle: UIModalPresentationStyle = .overFullScreen
    ) {
        self.bottomSheetHeight = bottomSheetHeight

        super.init(nibName: nil, bundle: nil)
        
        self.modalPresentationStyle = modalPresentationStyle
        setupLayout()
        setupGesture()
    }

    @available(*, unavailable)
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        showBottomSheets()
    }

    private func showBottomSheets() {
        bottomSheetViewBottomConstraint?.constant = 0
        UIView.animate(withDuration: animationDuration, animations: {
            self.dimmedView.alpha = 1.0
            self.view.layoutIfNeeded()
        })
    }

    public override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        bottomSheetViewBottomConstraint?.constant = bottomSheetHeight
        UIView.animate(withDuration: animationDuration, animations: {
            self.dimmedView.alpha = 0.0
            self.view.layoutIfNeeded()
        }) { _ in
            super.dismiss(animated: false, completion: completion)
        }
    }

    // MARK: - Setup Methods

    private func setupLayout() {
        view.addSubview(dimmedView)
        NSLayoutConstraint.activate([
            dimmedView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dimmedView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            dimmedView.topAnchor.constraint(equalTo: view.topAnchor),
            dimmedView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        view.addSubview(bottomSheetView)
        bottomSheetViewBottomConstraint = bottomSheetView.bottomAnchor.constraint(
            equalTo: dimmedView.bottomAnchor,
            constant: bottomSheetHeight
        )
        NSLayoutConstraint.activate([
            bottomSheetView.heightAnchor.constraint(equalToConstant: bottomSheetHeight),
            bottomSheetView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomSheetView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomSheetViewBottomConstraint!
        ])
        
        bottomSheetView.addSubview(indicator)
        NSLayoutConstraint.activate([
            indicator.widthAnchor.constraint(equalToConstant: 40),
            indicator.heightAnchor.constraint(equalToConstant: 4),
            indicator.topAnchor.constraint(equalTo: bottomSheetView.topAnchor, constant: 10),
            indicator.centerXAnchor.constraint(equalTo: bottomSheetView.centerXAnchor)
        ])
    }

    private func setupGesture() {
        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(dimmedViewDidTap)
        )
        dimmedView.addGestureRecognizer(tapGesture)

        let swipeGesture = UISwipeGestureRecognizer(
            target: self,
            action: #selector(didSwipeDown)
        )
        swipeGesture.direction = .down
        view.addGestureRecognizer(swipeGesture)
    }

    @objc private func dimmedViewDidTap(_ tapRecognizer: UITapGestureRecognizer) {
        dismiss(animated: false)
    }

    @objc private func didSwipeDown(_ swipeRecognizer: UISwipeGestureRecognizer) {
        if swipeRecognizer.state == .ended {
            switch swipeRecognizer.direction {
            case .down: dismiss(animated: false)
            default: break
            }
        }
    }
}
