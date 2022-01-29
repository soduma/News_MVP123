//
//  NaverAPI.swift
//  News_MVP
//
//  Created by 장기화 on 2022/01/29.
//

import Foundation

struct NaverAPI: Codable {
    let items: [News]
}

struct News: Codable {
    let title: String
    let link: String
    let description: String
    let pubDate: String
}
