//
//  WebViewController.swift
//  CrimeATravel
//
//  Created by Murodjon Ibrohimov on 8.06.22.
//  Copyright © 2022 CrimeATravel. All rights reserved.
//

import UIKit
import WebKit

final class WebViewController: BaseViewController {

    let url: String?
    let body: String?
    
    // MARK: UI variables.
    lazy var webView: WKWebView = {
        let webView = WKWebView()
        webView.navigationDelegate = self
        webView.scrollView.showsVerticalScrollIndicator = false
        webView.scrollView.showsHorizontalScrollIndicator = false
        view.addSubview(webView)
        return webView
    }()
    
    // MARK: Instance methods.
    init(url: String? = nil, body: String? = nil) {
        self.url = url
        self.body = body
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeConstraints()
        if !url.isNil {
            setupWithURL()
        } else if !body.isNil {
            setupWithBody()
        }
    }
    
    private func makeConstraints() {
        webView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupWithURL() {
        guard
            let urlStr = url,
            let url = URL(string: urlStr)
        else { return }
        webView.load(URLRequest(url: url))
    }
    
    private func setupWithBody() {
        guard let body = body else { return }
        let webViewString = "<html><body>\(body)</body></html>"
        let headerString = "<header><meta name='viewport' content='width=device-width," +
        "initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no'></header>"
        webView.loadHTMLString(headerString + webViewString, baseURL: nil)
    }
    
}

extension WebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        //stopLoading()
    }
}
