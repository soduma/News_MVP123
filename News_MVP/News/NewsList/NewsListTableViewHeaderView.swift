//
//  NewsListTableViewHeaderView.swift
//  News_MVP
//
//  Created by 장기화 on 2022/01/29.
//

import UIKit
import SnapKit
import TTGTags

protocol NewsListTableViewHeaderViewDelegate: AnyObject {
    func didSelectTag(_ selectedIndex: Int)
}

class NewsListTableViewHeaderView: UITableViewHeaderFooterView {
    static let identifier = "NewsListTableViewHeaderView"
    
    private weak var delegate: NewsListTableViewHeaderViewDelegate?
    private lazy var tagCollectionView = TTGTextTagCollectionView()
    private var tags: [String] = []
    private var isAddTag = false
    private var selectedIndex: UInt = 0
    
    func setup(tags: [String], delegate: NewsListTableViewHeaderViewDelegate) {
        self.tags = tags
        self.delegate = delegate
        
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
        tagCollectionView.selectionLimit = 2
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
        
        guard isAddTag == false else { return }
        tags.forEach { tag in
            let tagContent = TTGTextTagStringContent(text: tag, textFont: .systemFont(ofSize: 14, weight: .semibold), textColor: .systemOrange)
            let selectedTagContent = TTGTextTagStringContent(text: tag, textFont: .systemFont(ofSize: 14, weight: .semibold), textColor: .white)
            
            let tag = TTGTextTag(content: tagContent, style: style, selectedContent: selectedTagContent, selectedStyle: selectedStyle)
            tagCollectionView.addTag(tag)
            isAddTag = true
        }
    }
}

extension NewsListTableViewHeaderView: TTGTextTagCollectionViewDelegate {
    func textTagCollectionView(_ textTagCollectionView: TTGTextTagCollectionView!, didTap tag: TTGTextTag!, at index: UInt) {
        guard tag.selected else { return }
        
        if tagCollectionView.allSelectedTags().count == 1 {
            self.selectedIndex = index
            
        } else if tagCollectionView.allSelectedTags().count == 2 {
            tagCollectionView.updateTag(at: self.selectedIndex, selected: false)
            self.selectedIndex = index
            tagCollectionView.updateTag(at: index, selected: true)
        }
        
        delegate?.didSelectTag(Int(index))
    }
}
