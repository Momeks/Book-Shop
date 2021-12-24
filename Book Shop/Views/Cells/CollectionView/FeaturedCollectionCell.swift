//
//  FeaturedCollectionCell.swift
//  Book Shop
//
//  Created by Momeks on 12/23/21.
//

import UIKit

class FeaturedCollectionCell: UICollectionViewCell {

    @IBOutlet weak var banerImage: UIImageView!
    var id:Int!
    var featuredObjects : Featured?
    
    
    func setup() {
        let view = loadViewFromNib()
        view.frame = bounds
        
        addSubview(view)
    }

    
    func loadViewFromNib() -> UIView {
        let nib = UINib(nibName: "FeaturedCollectionCell", bundle: nil)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        
        return view
    }
    
    func updateFeaturedCell() {
        self.id = featuredObjects?.id ?? 0
        self.banerImage.image = UIImage(named: String(describing: self.id!))
        self.banerImage.layer.cornerRadius = 8.0
        self.banerImage.layer.masksToBounds = true
    }
    
}


extension UIView {
   
    func setupShadow() {
        self.layer.cornerRadius = 8
        self.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.layer.shadowRadius = 3
        self.layer.shadowOpacity = 0.3
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: 0, height: 1)).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }
    
}
