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
    
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        
   
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bookDetails = PLISTDataSerivce.shared.lookForBookWith(id: bookID)
        
    }
    
    

    func popUpAnimation(_ view:UIView, delay:TimeInterval)  {
        
        UIView.animate(withDuration: 1, delay: delay, usingSpringWithDamping: 0.40, initialSpringVelocity: 0.60, options: .allowUserInteraction, animations: {
            
            view.alpha = 0
            view.transform = CGAffineTransform(scaleX: 0.6, y: 0.6);
            view.transform = CGAffineTransform(scaleX: 1, y: 1);
            view.alpha = 1
            
            }, completion: nil)
        }

    
}


extension DetailsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
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
    
    
    
}
