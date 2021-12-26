//
//  Book3DViewController.swift
//  Book Shop
//
//  Created by Momeks on 12/26/21.
//

import UIKit
import SceneKit

class Book3DViewController: UIViewController {
    @IBOutlet weak var the3DScene: SCNView!
    var node:SCNNode!
    
    
    override func viewWillAppear(_ animated: Bool) {
        the3DScene.scene?.isPaused = false
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        the3DScene.scene?.isPaused = true
        node.removeFromParentNode()
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        the3DScene.backgroundColor = .clear
        the3DScene.autoenablesDefaultLighting = true
        the3DScene.allowsCameraControl = true
        
        //Load 3D scene:
        let scene = SCNScene(named: "3DBook.scnassets/book copy.dae")
        node = scene?.rootNode.childNodes.first!
        the3DScene.scene = scene
        

        
        
    }
    
}



