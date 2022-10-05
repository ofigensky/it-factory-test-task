
import Foundation
import UIKit

class CollectionViewTableViewCell: UITableViewCell {
    
    static let identifier = "CollectionViewTableViewCell"
    var jsonCaller = JSONCaller()
    private var sectionsModel: [Section] = [Section]()
        
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 140, height: 200)
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ArticleCollectionViewCell.self, forCellWithReuseIdentifier: ArticleCollectionViewCell.identifier)
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
        initTableViewData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = contentView.bounds
    
    }
    
    func initTableViewData() {
        jsonCaller.jsonCaller { [weak self] result in
            switch result {
            case .success(let sections):
                self?.sectionsModel = sections
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func setupWithViewModel() {
        // передавать из контроллера и обновлять коллекшн 
    }
}

extension CollectionViewTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ArticleCollectionViewCell.identifier, for: indexPath) as? ArticleCollectionViewCell else
        { return UICollectionViewCell() }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sectionsModel[section].itemsToShow
    }
}


//        let title = UILabel(frame: CGRect(x: 0, y: 0, width: cell.bounds.width, height: 70))
//        title.text = sectionsModel[indexPath.section].items[indexPath.row].title
//        title.numberOfLines = 0
//        title.font = UIFont(name: "AvenirNext-Bold", size: 15)
//        title.textAlignment = .center
//        cell.contentView.addSubview(title)
