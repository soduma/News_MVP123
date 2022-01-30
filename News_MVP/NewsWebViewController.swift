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
    private let news: News
    private let webView = WKWebView()
    
    private let rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "doc.on.doc.fill"), style: .plain, target: self, action: #selector(didTapRightBarButtonItem))
    
    init(news: News) {
        self.news = news
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        setupNavigation()
        setupWebView()
    }
}

private extension NewsWebViewController {
    func setupNavigation() {
        navigationItem.title = news.newTitle
        navigationItem.rightBarButtonItem = rightBarButtonItem
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    func setupWebView() {
        guard let url = URL(string: news.link) else {
            navigationController?.popViewController(animated: true)
            return
        }
        
        view = webView
        
        let urlRequest = URLRequest(url: url)
        webView.load(urlRequest)
    }
    
    @objc func didTapRightBarButtonItem() {
        UIPasteboard.general.string = news.link
    }
}
