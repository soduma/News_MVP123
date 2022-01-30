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
    func moveToNewsWebView(with news: News)
    func reloadTableView()
}

class NewsListPresenter: NSObject {
    private weak var viewController: NewsListProtocol?
    private let newsManager: NewsManagerProtocol
    
    private var newsList: [News] = []
    private var currentKeyword = ""
    private var currentPage = 0
    private let display = 20
    
    private var tags: [String] = ["IT", "아이폰", "애플", "IOS", "개발", "판교", "게임", "강남", "스타트업"]
    
    init(viewController: NewsListProtocol, newsManager: NewsManagerProtocol = NewsManager()) {
        self.viewController = viewController
        self.newsManager = newsManager
    }
    
    func viewDidLoad() {
        viewController?.setupNavigation()
        viewController?.setupLayout()
    }
    
    func didCalledRefresh() {
        requestNews(isNeedtoReset: true)
    }
}

extension NewsListPresenter: NewsListTableViewHeaderViewDelegate {
    func didSelectTag(_ selectedIndex: Int) {
        currentKeyword = tags[selectedIndex]
        requestNews(isNeedtoReset: true)
    }
}

extension NewsListPresenter: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewController?.moveToNewsWebView(with: newsList[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let currentRow = indexPath.row
        guard (currentRow % 20 == display - 3),
              (currentRow / display == currentPage - 1) else { return }
        requestNews(isNeedtoReset: false)
    }
}

extension NewsListPresenter: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsListTableViewCell.identifier, for: indexPath) as? NewsListTableViewCell else { return UITableViewCell() }
        cell.accessoryType = .disclosureIndicator
        cell.selectionStyle = .none
        cell.layoutIfNeeded() // 이거 넣어야 셀높이 맞음
        cell.setup(news: newsList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: NewsListTableViewHeaderView.identifier) as? NewsListTableViewHeaderView
        header?.setup(tags: tags, delegate: self)
        header?.layoutIfNeeded()
        return header
    }
}

private extension NewsListPresenter {
    func requestNews(isNeedtoReset: Bool) {
        if isNeedtoReset {
            currentPage = 0
            newsList = []
        }
        
        newsManager.fetchNews(
            from: currentKeyword, display: display, start: currentPage * display + 1) { [weak self] newValue in
                self?.newsList += newValue
                self?.currentPage += 1
                self?.viewController?.reloadTableView()
                
                self?.viewController?.endRefreshing()
            }
    }
}
