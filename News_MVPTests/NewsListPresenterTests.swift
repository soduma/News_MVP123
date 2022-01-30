//
//  NewsListPresenterTests.swift
//  News_MVPTests
//
//  Created by 장기화 on 2022/01/27.
//

import XCTest
@testable import News_MVP

class NewsListPresenterTests: XCTestCase {
    var sut: NewsListPresenter!
    
    var viewController: MockNewsListViewController!
    var newsManager: MockNewsManager!
    
    override func setUp() {
        super.setUp()
        
        viewController = MockNewsListViewController()
        newsManager = MockNewsManager()
        
        sut = NewsListPresenter(viewController: viewController, newsManager: newsManager)
    }
    
    override func tearDown() {
        sut = nil
        
        viewController = nil
        newsManager = nil
        
        super.tearDown()
    }
    
    func test_viewDidLoad가실행될때() {
        sut.viewDidLoad()
        
        XCTAssertTrue(viewController.isCalledSetupNavigation)
        XCTAssertTrue(viewController.isCalledSetupLayout)
    }
    
    func test_didCalledRefresh가실행될때request가실패하면() {
        newsManager.error = NSError() as Error
        sut.didCalledRefresh()
        
        XCTAssertFalse(viewController.isCalledReloadTableView)
        XCTAssertFalse(viewController.isCalledEndRefreshing)
    }
    
    func test_didCalledRefresh가실행될때request가성공하면() {
        newsManager.error = nil
        sut.didCalledRefresh()
        
        XCTAssertTrue(viewController.isCalledReloadTableView)
        XCTAssertTrue(viewController.isCalledEndRefreshing)
    }
}

