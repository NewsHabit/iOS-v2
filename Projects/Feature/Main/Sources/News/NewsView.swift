//
//  NewsView.swift
//  SharedDesignSystem
//
//  Created by 지연 on 8/30/24.
//

import UIKit
import WebKit

import Shared

import PinLayout

public final class NewsView: UIView {
    // MARK: - Components
    
    let progressView = {
        let view = UIProgressView()
        view.progressViewStyle = .bar
        view.tintColor = Colors.gray08
        view.sizeToFit()
        return view
    }()
    
    let webView = {
        let config = WKWebViewConfiguration()
        config.allowsInlineMediaPlayback = true
        let view = WKWebView(frame: .zero, configuration: config)
        view.allowsBackForwardNavigationGestures = true
        return view
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        webView.pin.all()
        progressView.pin.top().horizontally()
    }
    
    private func setupView() {
        addSubview(webView)
        addSubview(progressView)
    }
}
