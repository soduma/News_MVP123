//
//  NewsListTableViewHeaderView.swift
//  News_MVP
//
//  Created by 장기화 on 2022/01/29.
//

import UIKit
import SnapKit
import TTGTags

class NewsListTableViewHeaderView: UITableViewHeaderFooterView {
    static let identifier = "NewsListTableViewHeaderView"
    
    private lazy var tagCollectionView = TTGTextTagCollectionView()
    private var tags: [String] = ["IT", "IPHONE", "APPLE", "IOS", "개발", "판교", "게임", "강남", "스타트업"]
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.backgroundColor = .systemBackground
        setupTagCollectionViewLayout()
        setupTagCollectionView()
    }
}

private extension NewsListTableViewHeaderView {
    func setupTagCollectionViewLayout() {
        addSubview(tagCollectionView)
        
        tagCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func setupTagCollectionView() {
        tagCollectionView.delegate = self
        tagCollectionView.numberOfLines = 1
        tagCollectionView.scrollDirection = .horizontal
        tagCollectionView.showsHorizontalScrollIndicator = false
        tagCollectionView.selectionLimit = 1
        
        tagCollectionView.contentInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        
        let style = TTGTextTagStyle()
        style.backgroundColor = .white
        style.cornerRadius = 12
        style.borderColor = .systemOrange
        style.shadowOpacity = 0
        style.extraSpace = CGSize(width: 20, height: 12)
        
        let selectedStyle = TTGTextTagStyle()
        selectedStyle.backgroundColor = .systemOrange
        selectedStyle.cornerRadius = 12
        selectedStyle.borderWidth = 0
        selectedStyle.shadowOpacity = 0
        selectedStyle.extraSpace = CGSize(width: 20, height: 12)
        
        tags.forEach { tag in
            let tagContent = TTGTextTagStringContent(text: tag, textFont: .systemFont(ofSize: 14, weight: .semibold), textColor: .systemOrange)
            
            let selectedTagContent = TTGTextTagStringContent(text: tag, textFont: .systemFont(ofSize: 14, weight: .semibold), textColor: .white)
            
            let tag = TTGTextTag(content: tagContent, style: style, selectedContent: selectedTagContent, selectedStyle: selectedStyle)
            
            tagCollectionView.addTag(tag)
        }
    }
}

extension NewsListTableViewHeaderView: TTGTextTagCollectionViewDelegate {
    func textTagCollectionView(_ textTagCollectionView: TTGTextTagCollectionView!, didTap tag: TTGTextTag!, at index: UInt) {
        guard tag.selected else { return }
        print(tags[Int(index)])
    }
}
