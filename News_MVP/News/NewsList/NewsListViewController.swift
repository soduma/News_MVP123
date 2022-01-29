//
//  NewsListViewController.swift
//  News_MVP
//
//  Created by 장기화 on 2022/01/27.
//

import UIKit
import SnapKit

class NewsListViewController: UIViewController {
    private lazy var presenter = NewsListPresenter(viewController: self)
    
    private lazy var refreshControl: UIRefreshControl = {
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(didCalledRefresh), for: .valueChanged)
        return refresh
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = presenter
        tableView.dataSource = presenter
        tableView.refreshControl = refreshControl
        
        tableView.register(NewsListTableViewCell.self, forCellReuseIdentifier: NewsListTableViewCell.identifier)
        tableView .register(NewsListTableViewHeaderView.self, forHeaderFooterViewReuseIdentifier: NewsListTableViewHeaderView.identifier)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidLoad()
    }
}

extension NewsListViewController: NewsListProtocol {
    func setupNavigation() {
        navigationItem.title = "News"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func setupLayout() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func endRefreshing() {
        refreshControl.endRefreshing()
    }
    
    func moveToNewsWebView() {
        let newsWebViewController = NewsWebViewController()
        navigationController?.pushViewController(newsWebViewController, animated: true)
    }
}

private extension NewsListViewController {
    @objc func didCalledRefresh() {
        presenter.didCalledRefresh()
    }
}
