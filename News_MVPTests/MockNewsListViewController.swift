//
//  MockNewsListViewController.swift
//  News_MVPTests
//
//  Created by 장기화 on 2022/01/30.
//

import XCTest
@testable import News_MVP

final class MockNewsListViewController: NewsListProtocol {
    var isCalledSetupNavigation = false
    var isCalledSetupLayout = false
    var isCalledEndRefreshing = false
    var isCalledMoveToNewsWebView = false
    var isCalledReloadTableView = false
    
    func setupNavigation() {
        isCalledSetupNavigation = true
    }
    
    func setupLayout() {
        isCalledSetupLayout = true
    }
    
    func endRefreshing() {
        isCalledEndRefreshing = true
    }
    
    func moveToNewsWebView(with news: News) {
        isCalledMoveToNewsWebView = true
    }
    
    func reloadTableView() {
        isCalledReloadTableView = true
    }
}
