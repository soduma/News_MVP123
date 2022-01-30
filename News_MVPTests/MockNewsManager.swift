//
//  MockNewsManager.swift
//  News_MVPTests
//
//  Created by 장기화 on 2022/01/30.
//

import XCTest
@testable import News_MVP

final class MockNewsManager: NewsManagerProtocol {
    var error: Error?
    var isCalledRequest = false
    
    func fetchNews(from keyword: String, display: Int, start: Int, completionHandler: @escaping ([News]) -> Void) {
        isCalledRequest = true
        
        if error == nil {
            completionHandler([])
        }
    }
}
