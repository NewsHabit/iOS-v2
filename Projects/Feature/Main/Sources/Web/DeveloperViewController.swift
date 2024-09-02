//
//  DeveloperViewController.swift
//  FeatureMain
//
//  Created by 지연 on 9/3/24.
//

import UIKit
import WebKit

import Shared

public final class DeveloperViewController: BaseViewController<NewsHabitWebView> {
    private var progressObserver: NSKeyValueObservation?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupProgressObserver()
        loadWebView(with: URL(string: "https://newshabit.org"))
    }
    
    deinit {
        progressObserver?.invalidate()
        webView.stopLoading()
    }
    
    private func setupNavigationBar() {
        setBackButton()
    }
    
    private func setupProgressObserver() {
        progressObserver = webView
            .observe(\.estimatedProgress, options: .new) { [weak self] webView, _ in
                self?.progressView.setProgress(Float(webView.estimatedProgress), animated: true)
            }
    }
    
    private func loadWebView(with url: URL?) {
        guard let url = url else { return }
        webView.navigationDelegate = self
        webView.load(URLRequest(url: url))
    }
    
    @objc private func handleSharedButtonTap() {
        print("share")
    }
}

extension DeveloperViewController: WKNavigationDelegate {
    public func webView(
        _ webView: WKWebView,
        didStartProvisionalNavigation navigation: WKNavigation!
    ) {
        progressView.isHidden = false
        progressView.setProgress(0.0, animated: false)
    }
    
    public func webView(
        _ webView: WKWebView,
        didFinish navigation: WKNavigation!
    ) {
        progressView.setProgress(1.0, animated: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.progressView.isHidden = true
        }
    }
    
    public func webView(
        _ webView: WKWebView,
        decidePolicyFor navigationAction: WKNavigationAction,
        decisionHandler: @escaping (WKNavigationActionPolicy
        ) -> Void) {
        // "새 창으로 열기" 링크 WebView 내에서 열기
        if navigationAction.targetFrame == nil {
            webView.load(navigationAction.request)
        }
        decisionHandler(.allow)
    }
}

private extension DeveloperViewController {
    var progressView: UIProgressView {
        contentView.progressView
    }
    
    var webView: WKWebView {
        contentView.webView
    }
}
