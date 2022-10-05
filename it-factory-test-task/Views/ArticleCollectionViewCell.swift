
import Foundation
import UIKit

class ArticleCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "ArticleCollectionViewCell"
    
    private let cellImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "house") //заменить на изображения из json'a
        return imageView
    }()
    
    private let cellTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "random" //заменить на title из json'a
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(cellImageView)
        contentView.addSubview(cellTitleLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        cellImageView.frame = contentView.bounds
        cellTitleLabel.frame = contentView.bounds
    }
}
