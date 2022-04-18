//
//  BookmarkViewController.swift
//  Book Shop
//
//  Created by Momeks on 12/27/21.
//

import UIKit
import AlamofireImage
import CoreData


class BookmarkViewController: UIViewController {
	
	//MARK: 🔻 Vars and outletes
	var collectionView: CollectionView!
	var collectionFlowLayout = UICollectionViewFlowLayout()
	@IBOutlet weak var status: UILabel!
	var bookmarkData: [Entity] = []
	
	
	//MARK: 🔻 App Cycle
	override func viewWillAppear(_ animated: Bool) {
		//Set nav title
		self.tabBarController?.title = "Bookmarks"
		
		//Fetch Favorites from Core Data
		bookmarkData = CoreDataService.shared.loadBookmarkData()
		collectionView.reloadData()
		
		if bookmarkData.count == 0 {
			status.isHidden = false
		} else {
			status.isHidden = true
		}
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		setupCollectionView()
	}
}


//MARK: 🔻 Setup CollectionView
extension BookmarkViewController: UICollectionViewDataSource, UICollectionViewDelegate {
	
	func setupCollectionView() {
		
		collectionView = CollectionView(frame:view.frame, collectionViewLayout: collectionFlowLayout)
		
		collectionView.register(cell: BookCollectionCell.self)
		collectionView.dataSource = self
		collectionView.delegate = self
		collectionView.backgroundColor = .clear
		view.addSubview(collectionView)
		
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		
		let constraints = [
			collectionView.topAnchor.constraint(equalTo: view.topAnchor),
			collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
			collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
			collectionView.rightAnchor.constraint(equalTo: view.rightAnchor)
		]
		
		NSLayoutConstraint.activate(constraints)
		
	}

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return bookmarkData.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookCollectionCell", for: indexPath) as! BookCollectionCell
		cell.updateBookCellWithCoreData(bookmarkData[indexPath.row])
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		
		let cell = collectionView.cellForItem(at: indexPath) as! BookCollectionCell
		cell.bookObject = PLISTDataSerivce.shared.lookForBookWith(id: cell.id)
		BookCovers.shared.cover = cell.cover.image
		BookCovers.shared.backCover = BookCovers.shared.backCover(title: cell.bookObject?.title ?? "",
																  author: cell.bookObject?.author ?? "",
																  description: cell.bookObject?.summary ?? "",
																  color: cell.bookObject?.color ?? "")
		
		BookCovers.shared.sideCover = BookCovers.shared.sideCover(title: cell.bookObject?.title ?? "", color: cell.bookObject?.color ?? "")
		presentBookDetailsWith(id: cell.id)
	}
}

//MARK: 🔻 Setup CollectionView Flow Layout
extension BookmarkViewController: UICollectionViewDelegateFlowLayout {
	
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
		return CGSize(width: 120, height: 186)
	}
}
