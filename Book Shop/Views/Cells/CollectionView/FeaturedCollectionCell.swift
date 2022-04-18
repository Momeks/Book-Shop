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

	func loadViewFromNib() -> UIView {
		let nib = UINib(nibName: "FeaturedCollectionCell", bundle: nil)
		let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
		return view
	}
	
	func updateFeaturedCell(_ featured: Featured) {
		self.id = featured.id ?? 0
		self.banerImage.image = UIImage(named: String(describing: self.id!))
		self.banerImage.layer.cornerRadius = 8.0
		self.banerImage.layer.masksToBounds = true
		self.layer.rasterizationScale = UIScreen.main.scale
		self.layer.shouldRasterize = true
		self.addShadow(cornerRadius: 2.0, shadowRadius: 6.0, shadowOpacity: 0.5, shadowPathInset:  (dx: 10, dy: 18), shadowPathOffset:  (dx: 0, dy: 1))
	}
}
