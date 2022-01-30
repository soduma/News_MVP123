//
//  String+.swift
//  News_MVP
//
//  Created by 장기화 on 2022/01/30.
//

import Foundation

// 사용하지 않았음
extension String {
    var htmlToString: String {
        guard let data = self.data(using: .utf8) else { return "" }
        
        do {
            return try NSAttributedString(
                data: data,
                options: [
                    .documentType: NSAttributedString.DocumentType.html,
                    .characterEncoding: String.Encoding.utf8.rawValue
                         ],
                documentAttributes: nil).string
        } catch {
            return ""
        }
    }
}
