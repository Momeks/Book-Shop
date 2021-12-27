//
//  DetailsViewController.swift
//  Book Shop
//
//  Created by Momeks on 12/25/21.
//

import UIKit

class DetailsViewController: UIViewController {

    var bookID:Int!
    @IBOutlet weak var tableView: UITableView!
    var bookDetails:Book?
    var items = 0
    @IBOutlet weak var bookmarkButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.allowsSelection = false
        
        bookDetails = PLISTDataSerivce.shared.lookForBookWith(id: bookID)
        
        //Register for table cell animation
        NotificationCenter.default.addObserver(self, selector: #selector(animateTableCell), name: NSNotification.Name("animateTableCell"), object: nil)
        
        
        if  CoreDataService.shared.bookmarkContainsBook(id: bookID) ==  (bookID != nil) {
            bookmarkButton.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
            bookmarkButton.isSelected = true
        }  else {
            bookmarkButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
            bookmarkButton.isSelected = false
        }
        
    }
    
    

    func popUpAnimation(_ view:UIView, delay:TimeInterval)  {
        
        UIView.animate(withDuration: 1, delay: delay, usingSpringWithDamping: 0.40, initialSpringVelocity: 0.60, options: .allowUserInteraction, animations: {
            
            view.alpha = 0
            view.transform = CGAffineTransform(scaleX: 0.6, y: 0.6);
            view.transform = CGAffineTransform(scaleX: 1, y: 1);
            view.alpha = 1
            
            }, completion: nil)
        }

    
    
    
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func addToBookmark(_ sender: UIButton) {

        sender.isSelected = !sender.isSelected
        
        if sender.isSelected {
            CoreDataService.shared.addToBookmark(book: bookDetails!)
            sender.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
            print("add to bookmark")
        } else {
            CoreDataService.shared.deleteBookWith(id: bookID)
            sender.setImage(UIImage(systemName: "bookmark"), for: .normal)
            print("remove from bookmark")
        }
        
    }
    
    
}


extension DetailsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifierFor(row: indexPath.row), for: indexPath) as! DetailsTableCell
     
        switch indexPath.row {
        case 0:
            cell.bookTitle.text = bookDetails?.title ?? ""
        case 1:
            cell.author.text = "By \(bookDetails?.author ?? "")"
        case 2:
            cell.descriptions.text = bookDetails?.summary ?? ""
        case 3:
            cell.pages.text = String(describing: bookDetails?.pages ?? 0)
            cell.publisher.text = bookDetails?.publisher ?? ""
            cell.publishDate.text = bookDetails?.publishDate ?? ""
        default:
            break
        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    
    
    func cellIdentifierFor(row:Int) -> String {
        
        var cellID:String?
        
        switch row {
        case 0:
            cellID = "title"
        case 1:
            cellID = "author"
        case 2:
            cellID = "descriptions"
        case 3:
            cellID = "info"
        default:
            cellID = ""
        }
        
        return cellID ?? ""
    }
    
    
  @objc  func animateTableCell() {
        items = 4
      
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
