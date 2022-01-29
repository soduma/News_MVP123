//
//  NewsListPresenter.swift
//  News_MVP
//
//  Created by 장기화 on 2022/01/28.
//

import UIKit

protocol NewsListProtocol: AnyObject {
    func setupNavigation()
    func setupLayout()
    func endRefreshing()
}

class NewsListPresenter: NSObject {
    private weak var viewController: NewsListProtocol?
    
    init(viewController: NewsListProtocol) {
        self.viewController = viewController
    }
    
    func viewDidLoad() {
        viewController?.setupNavigation()
        viewController?.setupLayout()
    }
    
    func didCalledRefresh() {
        viewController?.endRefreshing()
    }
}

extension NewsListPresenter: UITableViewDelegate {
    
}

extension NewsListPresenter: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsListTableViewCell.identifier, for: indexPath) as? NewsListTableViewCell else { return UITableViewCell() }
        cell.accessoryType = .disclosureIndicator
        cell.selectionStyle = .none
        cell.layoutIfNeeded() // 이거 넣어야 셀높이 맞음
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: NewsListTableViewHeaderView.identifier) as? NewsListTableViewHeaderView
        header?.layoutIfNeeded()
        return header
    }
}
