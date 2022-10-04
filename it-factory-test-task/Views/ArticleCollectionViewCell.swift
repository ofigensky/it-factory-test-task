//
//  ArticleCollectionViewCell.swift
//  it-factory-test-task
//
//  Created by Gleb Glushok on 03.10.2022.
//

import Foundation
import UIKit

class ArticleCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "ArticleCollectionViewCell"
    
    private let articleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.image = UIImage(systemName: "house")
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(articleImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        articleImageView.frame = contentView.bounds
    }
}
