//
//  BooksViewController.swift
//  Book Shop
//
//  Created by Momeks on 12/23/21.
//

import UIKit
import Alamofire
import AlamofireImage

class BooksViewController: UIViewController {


    @IBOutlet weak var tableView: UITableView!
    var featuredBooks : [Featured] = []
    var bestSeller : [Book] = []
    var newArrival : [Book] = []
    
    override func viewWillAppear(_ animated: Bool) {
        //Set nav title
        self.tabBarController?.title = "Book Store"
    
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
    
        //Fetch Data
        featuredBooks = [Featured(id: 100), Featured(id: 102), Featured(id: 110), Featured(id: 112), Featured(id: 115), Featured(id: 121)]
        bestSeller = PLISTDataSerivce.shared.getDataFrom(plist: "Best Seller")
        newArrival = PLISTDataSerivce.shared.getDataFrom(plist: "New Arrival")
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
        view.backgroundColor = .systemBackground
        
        // Section title
        let title = UILabel(frame: CGRect(x: 10, y: 3, width: tableView.frame.width, height: 20))
        title.text = section.rawValue
        
        title.font = UIFont(name: "Georgia-Bold", size: 20)
        title.textColor = .label
        view.addSubview(title)
    
            return view
    }


    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return  200
    }
   
    
  
    func animateTableCell() {
        tableView.reloadData()
        
        let cells = tableView.visibleCells
        let tableHeight: CGFloat = tableView.bounds.size.height
        
        for i in cells {
            let cell: UITableViewCell = i as UITableViewCell
            cell.transform = CGAffineTransform(translationX: 0, y: tableHeight)
        }
        
        var index = 0
        
        for a in cells {
            let cell: UITableViewCell = a as UITableViewCell
            
            UIView.animate(withDuration: 1.1, delay: 0.05 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [], animations: {
                
                cell.alpha = 0
                cell.alpha = 1
                
                cell.transform = CGAffineTransform(translationX: 0, y: 0);
            }, completion: nil)
            
            index += 1
        }
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
        case .bestSeller , .newArrivals:
            return section == .bestSeller ? bestSeller.count : newArrival.count
        }
    }
    

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let section = BooksCategory.allCases[collectionView.tag]
        
        switch section {
            
        case .featured:
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeaturedCollectionCell", for: indexPath) as! FeaturedCollectionCell
            cell.featuredObjects = featuredBooks[indexPath.row]
            cell.updateFeaturedCell()
            return cell
            
        case .bestSeller , .newArrivals:
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookCollectionCell", for: indexPath) as! BookCollectionCell
            cell.bookObject = section == .bestSeller ? bestSeller[indexPath.row] : newArrival[indexPath.row]
            cell.updateBookCellContents()
            return cell
        }
    
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let section = BooksCategory.allCases[collectionView.tag]
    
        switch section {
            
        case .featured:
            
            let cell = collectionView.cellForItem(at: indexPath) as! FeaturedCollectionCell
            
            let data = PLISTDataSerivce.shared.lookForBookWith(id: cell.id)
            
            BookCovers.shared.sideCover = BookCovers.shared.sideCover(title: data.title ?? "", color: data.color ?? "")
          
            BookCovers.shared.backCover = BookCovers.shared.backCover(title: data.title ?? "",
                                                                      author: data.author ?? "",
                                                                      description: data.summary ?? "",
                                                                      color: data.color ?? "")
           
            BookCovers.shared.cover = UIImage(named:"c-\(cell.id!)")
        
            self.presentBookDetailsWith(id: cell.id)

    
        case .bestSeller , .newArrivals:
          
            let cell = collectionView.cellForItem(at: indexPath) as! BookCollectionCell
           
            BookCovers.shared.cover = cell.cover.image
            
            BookCovers.shared.backCover = BookCovers.shared.backCover(title: cell.bookObject?.title ?? "",
                                                                      author: cell.bookObject?.author ?? "",
                                                                      description: cell.bookObject?.summary ?? "",
                                                                      color: cell.bookObject?.color ?? "")
            
            BookCovers.shared.sideCover = BookCovers.shared.sideCover(title: cell.bookObject?.title ?? "", color: cell.bookObject?.color ?? "")
            presentBookDetailsWith(id: cell.id)
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
        
        let section = BooksCategory.allCases[collectionView.tag]
        
        if section == .featured {
            return CGSize(width: 340, height: 208)
        } else {
            return CGSize(width: 120, height: 186)
        }
    
    }
    
   

}

