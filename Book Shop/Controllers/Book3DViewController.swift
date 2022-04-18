//
//  Book3DViewController.swift
//  Book Shop
//
//  Created by Momeks on 12/26/21.
//

import UIKit
import SceneKit


class Book3DViewController: UIViewController {
	
	//MARK: 🔻 Variables and outlets
	@IBOutlet weak var the3DScene: SCNView!
	@IBOutlet weak var contentView: UIView!
	var node: SCNNode!
	var didEnd = false
	
	
	//MARK: 🔻 View Cycle
	override func viewWillAppear(_ animated: Bool) {
		if didEnd == false {
			popUpAnimation()
			setup3DBook()
		}
	}

	override func viewDidDisappear(_ animated: Bool) {
		the3DScene.scene?.isPaused = true
		node.removeFromParentNode()
	}

	override func viewDidLoad() {
		super.viewDidLoad()
	}
	

	//MARK: 🔻 Setup 3D Book
	func setup3DBook() {
		the3DScene.backgroundColor = .clear
		the3DScene.autoenablesDefaultLighting = true
		the3DScene.allowsCameraControl = true
		
		//Load 3D scene:
		let scene = SCNScene(named: "3DBook.scnassets/book.dae")
		node = scene?.rootNode.childNodes.first!
		the3DScene.scene = scene
		
		setMatrial()
	}
	
	func popUpAnimation()  {
		
		self.didEnd = true
		NotificationCenter.default.post(name: NSNotification.Name("animateTableCell"), object: nil)
		
		UIView.animate(withDuration: 1, delay: 0.5, usingSpringWithDamping: 0.40, initialSpringVelocity: 0.40, options: .allowUserInteraction, animations: { [self] in
			contentView.alpha = 0
			contentView.alpha = 1
			contentView.transform = CGAffineTransform(scaleX: 0.6, y: 0.6);
			contentView.transform = CGAffineTransform(scaleX: 1, y: 1);
		}, completion: { fin in
			self.animate360Degrees()
		})
	}
	
	func animate360Degrees() {
		let action = SCNAction.rotateBy(x: 0, y: CGFloat(GLKMathDegreesToRadians(360)), z: 0, duration: 60)
		let forever = SCNAction.repeatForever(action)
		node.runAction(forever)
	}
	
	func setMatrial() {
		
		//Cover
		let coverMaterial = SCNMaterial()
		coverMaterial.diffuse.contents = BookCovers.shared.cover
		coverMaterial.diffuse.contentsTransform =  SCNMatrix4Translate(SCNMatrix4MakeScale(-1, 1, 1), 1, 0, 0)
		let coverNode = node.childNode(withName: "cover", recursively: true)
		coverNode?.geometry?.materials = [coverMaterial]
		
		//Back Cover
		let backCoverMaterial = SCNMaterial()
		backCoverMaterial.diffuse.contents = BookCovers.shared.backCover
		backCoverMaterial.diffuse.contentsTransform =  SCNMatrix4Translate(SCNMatrix4MakeScale(-1, 1, 1), 1, 0, 0)
		let backCoverNode = node.childNode(withName: "back", recursively: true)
		backCoverNode?.geometry?.materials = [backCoverMaterial]
		
		//Side Cover
		let sideCoverMaterial = SCNMaterial()
		sideCoverMaterial.diffuse.contents = BookCovers.shared.sideCover
		sideCoverMaterial.diffuse.contentsTransform =  SCNMatrix4Translate(SCNMatrix4MakeScale(-1, 1, 1), 1, 0, 0)
		let sidekCoverNode = node.childNode(withName: "side", recursively: true)
		sidekCoverNode?.geometry?.materials = [sideCoverMaterial]
	}
}

