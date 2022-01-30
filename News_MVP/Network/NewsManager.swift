//
//  NewsManager.swift
//  News_MVP
//
//  Created by 장기화 on 2022/01/29.
//

import Foundation
import Alamofire

protocol NewsManagerProtocol {
    func fetchNews(from keyword: String, display: Int, start: Int, completionHandler: @escaping ([News]) -> Void)
}

struct Parameter: Codable {
    /// 검색어
    let query: String
    /// 검색 결과 출력 건수, 10 ~ 100
    let display: Int
    /// 시작 Index, 1 ~ 1000
    let start: Int
}

struct NewsManager: NewsManagerProtocol {
    func fetchNews(from keyword: String, display: Int, start: Int, completionHandler: @escaping ([News]) -> Void) {
        guard let url = URL(string: "https://openapi.naver.com/v1/search/news.json") else { return }
        
        let parameters = Parameter(query: keyword, display: display, start: start)
        let headers: HTTPHeaders = [
            "X-Naver-Client-Id": "201FemwuZ7HTebMDK3uG",
            "X-Naver-Client-Secret": "Oqv5e6oDcp"
        ]
        
        AF
            .request(url, method: .get, parameters: parameters, headers: headers)
            .responseDecodable(of: NaverAPI.self) { response in
                switch response.result {
                case .success(let result):
                    completionHandler(result.items)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            .resume()
    }
}
