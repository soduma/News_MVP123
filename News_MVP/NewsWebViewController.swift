//
//  NewsWebViewController.swift
//  News_MVP
//
//  Created by 장기화 on 2022/01/29.
//

import UIKit
import WebKit
import SnapKit

class NewsWebViewController: UIViewController {
    private let webView = WKWebView()
    
    private let rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "doc.on.doc.fill"), style: .plain, target: self, action: #selector(didTapRightBarButtonItem))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        setupNavigation()
        setupWebView()
    }
}

private extension NewsWebViewController {
    func setupNavigation() {
        navigationItem.title = "ㅎㅇㅎㅇ 기사제목"
        navigationItem.rightBarButtonItem = rightBarButtonItem
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    func setupWebView() {
        guard let url = URL(string: "https://www.naver.com") else {
            navigationController?.popViewController(animated: true)
            return
        }
        
        view = webView
        
        let urlRequest = URLRequest(url: url)
        webView.load(urlRequest)
    }
    
    @objc func didTapRightBarButtonItem() {
        UIPasteboard.general.string = "new link"
    }
}
