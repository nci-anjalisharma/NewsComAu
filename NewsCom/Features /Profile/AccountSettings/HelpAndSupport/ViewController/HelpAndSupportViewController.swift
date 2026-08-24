//
//  TextSizeViewController.swift
//  NewsCom
//
//  Created by ANJALI SHARMA R on 09/04/26.
//

import UIKit
import WebKit
import SnapKit

class HelpAndSupportViewController: UIViewController {

    private let webView = WKWebView()
    private let activityIndicator = UIActivityIndicatorView(style: .large)

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Help & Support"
        view.backgroundColor = .systemBackground

        setupWebView()
        loadWebsite()
    }

    private func setupWebView() {

//       webView.navigationDelegate = self

        view.addSubview(webView)
        view.addSubview(activityIndicator)

        webView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }

        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }

    private func loadWebsite() {

        guard let url = URL(string: "https://www.news.com.au/help") else {
            print("Invalid URL")
            return
        }

        let request = URLRequest(url: url)
        webView.load(request)
    }
}
////
//extension HelpAndSupportViewController: WKNavigationDelegate {
//
//    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
//
//        activityIndicator.startAnimating()
//        print("Started Loading")
//    }
//
//    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
//
//        activityIndicator.stopAnimating()
//        print("Finished Loading")
//    }
//
//    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
//
//        activityIndicator.stopAnimating()
//        print("Navigation Error: \(error.localizedDescription)")
//    }
//
//    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
//
//        activityIndicator.stopAnimating()
//        print("Provisional Error: \(error.localizedDescription)")
//    }
//}
