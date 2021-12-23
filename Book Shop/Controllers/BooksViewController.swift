//
//  BooksViewController.swift
//  Book Shop
//
//  Created by Momeks on 12/23/21.
//

import UIKit

class BooksViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var featuredBooks : [Featured] = []
    
    
    override func viewWillAppear(_ animated: Bool) {
        //Set nav title
        self.tabBarController?.title = "Book Store"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        featuredBooks = [Featured(id: 100), Featured(id: 102), Featured(id: 110), Featured(id: 112), Featured(id: 115), Featured(id: 121)]
        
    }
    
}


extension BooksViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return BooksCategory.allCases.count
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       // let section = BooksCategory.allCases[indexPath.section]
        var cell = tableView.dequeueReusableCell(withIdentifier: BooksTableCell.identifier) as? BooksTableCell
    
        if cell == nil {
            cell = BooksTableCell(style: .default, reuseIdentifier: BooksTableCell.identifier)
            cell?.collectionFlowLayout.scrollDirection = .horizontal
        }
        
        return cell!
    }
    
    
    
    
    func tableView(_: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
       guard let cell: BooksTableCell = cell as? BooksTableCell else { return }
       cell.setCollectionView(dataSource: self, delegate: self, indexPath: indexPath)
    }
    
    
    
    //Header's title
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let section = BooksCategory.allCases[section]
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 50))
        view.backgroundColor = .clear
        
        // Section title
        let title = UILabel(frame: CGRect(x: 10, y: 0, width: tableView.frame.width, height: 20))
        title.text = section.rawValue
        
        title.font = UIFont(name: "Georgia-Bold", size: 20)
        title.textColor = .label
        view.addSubview(title)
        
        
        //See More button
        let button = UIButton(frame: CGRect(x: tableView.frame.maxX - 130 , y: 0, width: 200, height: 20))
        button.setTitle("See All", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 10, weight: .medium)
        button.addTarget(self, action: #selector(seeAllBooks(_:)), for: .touchUpInside)
        button.tag = section.hashValue
        view.addSubview(button)
        
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return  200
    }
   
    
    @objc func seeAllBooks(_ button:UIButton) {
        
    }
    
    
}


//MARK: 🔻 Setup CollectionView
extension BooksViewController: UICollectionViewDelegate, UICollectionViewDataSource {
  
    func numberOfSections(in _: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let section = BooksCategory.allCases[collectionView.tag]
        
        switch section {
        case .featured:
            return featuredBooks.count
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let section = BooksCategory.allCases[collectionView.tag]
        
        switch section {
            
        case .featured:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeaturedCollectionCell", for: indexPath) as! FeaturedCollectionCell
            
            cell.featuredObjects = featuredBooks[indexPath.row]
            
            cell.updateFeaturedCell()
            
            cell.layer.rasterizationScale = UIScreen.main.scale
            cell.layer.shouldRasterize = true
            
            return cell
            
        }
    
  
    }
    
    /*
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! MoviesCollectionCell
        presetnMovieDetailsWith(id: cell.id)
    
    }*/

}



//MARK: 🔻 Setup CollectionView Flow Layout
extension BooksViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout _: UICollectionViewLayout, insetForSectionAt _: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout _: UICollectionViewLayout, minimumLineSpacingForSectionAt _: Int) -> CGFloat {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, layout _: UICollectionViewLayout, minimumInteritemSpacingForSectionAt _: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout _: UICollectionViewLayout, sizeForItemAt _: IndexPath) -> CGSize {
        return CGSize(width: 340, height: 215)
        
    }
    
   
    
}
