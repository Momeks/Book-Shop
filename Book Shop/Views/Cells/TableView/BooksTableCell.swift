//
//  BooksTableViewCell.swift
//  Book Shop
//
//  Created by Momeks on 12/23/21.
//

import UIKit

//MARK: - CollectionView
class CollectionView: UICollectionView {
    var indexPath: IndexPath!
}


class BooksTableCell: UITableViewCell {

    static let identifier = "BooksTableCell"
    var collectionView: CollectionView!
    var collectionFlowLayout = UICollectionViewFlowLayout()
  
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        
        collectionView = CollectionView(frame: .zero, collectionViewLayout: collectionFlowLayout)
        
        // register cells
        
        //First Cell: Featured Books
        collectionView.register(cell: FeaturedCollectionCell.self)
        collectionView.register(cell: BookCollectionCell.self)
        collectionView.register(cell: BookCollectionCell.self)
        
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.bounces = true
        collectionView.isDirectionalLockEnabled = true
        collectionView.isMultipleTouchEnabled = false
        collectionView.isOpaque = true
  
        collectionView.backgroundColor = .clear
        self.backgroundColor = .clear

        
        contentView.addSubview(collectionView)
    }

    
    //MARK: - init

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    final override func layoutSubviews() {
        super.layoutSubviews()
        guard collectionView.frame != contentView.bounds else { return }
        collectionView.frame = contentView.bounds
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    
    
    //MARK: - setCollectionView
    final func setCollectionView(dataSource: UICollectionViewDataSource, delegate: UICollectionViewDelegate, indexPath: IndexPath) {
        
        collectionView.indexPath = indexPath
        collectionView.tag = indexPath.section

        if collectionView.dataSource == nil {
            collectionView.dataSource = dataSource
        }

        if collectionView.delegate == nil {
            collectionView.delegate = delegate
        }

        collectionView.reloadData()
    }

    
    
}
