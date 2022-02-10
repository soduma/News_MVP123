//
//  NewsListTableViewCell.swift
//  News_MVP
//
//  Created by 장기화 on 2022/01/28.
//

import UIKit
import SnapKit

class NewsListTableViewCell: UITableViewCell {
    static let identifier = "NewsListTableViewCell"
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .light)
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.textColor = .secondaryLabel
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        [titleLabel, descriptionLabel, dateLabel]
            .forEach { addSubview($0) }
        
        titleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(16)
            $0.trailing.equalToSuperview().inset(48)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
            $0.leading.trailing.equalTo(titleLabel)
        }
        
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(4)
            $0.leading.trailing.equalTo(titleLabel)
            $0.bottom.equalToSuperview().inset(16)
        }
    }
    
    func setup(news: News) {
        titleLabel.text = news.title.htmlToString
        descriptionLabel.text = news.description.htmlToString
        dateLabel.text = news.pubDate.htmlToString
    }
}
