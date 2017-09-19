//
//  GameViewController.swift
//  ScenesAndTransitions
//
//  Created by Robert Zhang on 12/29/16.
//  Copyright © 2016 Robert Zhang. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    
    override func viewDidLoad() {
        //To change the starting screen of your app, just change the "Home" 2 lines below to the name of your first screen
        super.viewDidLoad()
        let scene = Main(size: CGSize(width:self.view.frame.width*2, height:self.view.frame.height*2))
        let skView = self.view as! SKView
        skView.ignoresSiblingOrder = true
        scene.scaleMode = .aspectFill
        scene.size = self.view.bounds.size
        skView.presentScene(scene)
        skView.showsFPS = false
    }
    
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
