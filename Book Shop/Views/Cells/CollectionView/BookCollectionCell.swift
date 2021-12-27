//
//  BookCollectionCell.swift
//  Book Shop
//
//  Created by Momeks on 12/24/21.
//

import UIKit
import AlamofireImage


var resizeFilter :ImageFilter {
   AspectScaledToFillSizeFilter(size: CGSize(width: 150, height: 250))
}


class BookCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var cover: UIImageView!
    @IBOutlet weak var bookDepth: UIImageView!
    var id:Int!
    var bookObject : Book?
    var hexString:String!
    

    func loadViewFromNib() -> UIView {
        let nib = UINib(nibName: "BookCollectionCell", bundle: nil)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        return view
    }
    
    
    func updateBookCellContents() {
          
        UIView.animate(withDuration: 0.5, animations: {
            
            self.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            self.transform = CGAffineTransform(scaleX: 1, y: 1)
        })
        
            self.id = bookObject?.id ?? 0
            self.hexString = bookObject?.color ?? "00000"
            let coverURL = bookObject?.coverURL ?? ""
    
            DispatchQueue.main.async {
                self.cover.af.setImage(withURL: URL(string: coverURL)!, placeholderImage: UIImage(named: "Default"), filter: resizeFilter)
            }
            
            self.layer.rasterizationScale = UIScreen.main.scale
            self.layer.shouldRasterize = true
            self.cover.layer.cornerRadius = 5.0
            self.bookDepth.layer.cornerRadius = 5.0
            self.cover.layer.masksToBounds = true
            self.bookDepth.layer.masksToBounds = true
            
            self.addShadow(cornerRadius: 2.0, shadowRadius: 6.0, shadowOpacity: 0.5, shadowPathInset:  (dx: 10, dy: 18), shadowPathOffset:  (dx: 0, dy: 1))
            
        }

}
