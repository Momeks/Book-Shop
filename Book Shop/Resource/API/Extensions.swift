//
//  File.swift
//  Book Shop
//
//  Created by Momeks on 12/23/21.
//

import UIKit

extension UITableView {
    
    func register<Cell: UITableViewCell>(cell: Cell.Type) {
        let nibName = String(describing: Cell.self)
        self.register(UINib(nibName: nibName, bundle: nil), forCellReuseIdentifier: nibName)
    }
    
    func dequeue<Cell: UITableViewCell>() -> Cell  {
        let identifier = String(describing: Cell.self)
        guard let cell = self.dequeueReusableCell(withIdentifier: identifier) as? Cell else  {
            fatalError("Error in dequeue extension code !")
        }
        return cell
    }
  
}



extension UICollectionView {
    
    func register<Cell: UICollectionViewCell>(cell: Cell.Type) {
        let nibName = String(describing: Cell.self)
        self.register(UINib(nibName: nibName, bundle: nil), forCellWithReuseIdentifier: nibName)
    }
    
   
    func size(rows: CGFloat, columns: CGFloat) -> CGSize {
        let width = ( self.frame.width - ( columns * 10 ) - 10 ) / columns
        let height = ( self.frame.height - ( rows * 10 ) - 10 ) / rows
        return CGSize(width: width, height: height)
    }
    
    
}
