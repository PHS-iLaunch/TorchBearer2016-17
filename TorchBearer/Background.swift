//
//  Background.swift
//  TorchBearer
//
//  Created by Robert Zhang on 12/31/16.
//  Copyright © 2016 Robert Zhang. All rights reserved.
//

import SpriteKit

class Background:SKSpriteNode{
    var myScene:SKScene
    init(scene:SKScene){
        self.myScene = scene
        let texture = SKTexture(imageNamed: "Wall")
        super.init(texture:texture,color:.clear,size:texture.size())
        self.size = self.size
        self.position = CGPoint(x:self.frame.width/2,y:self.frame.height/2)
        self.zPosition = 0
        self.name = "bg"
        let move = SKAction.moveBy(x: -self.frame.width, y: 0, duration: 30)
        let remove = SKAction.removeFromParent()
        let action = SKAction.sequence([move,remove])
        self.run(action)
    }
    init(scene:SKScene,xPos:CGFloat){
        self.myScene = scene
        let texture = SKTexture(imageNamed: "Wall")
        super.init(texture:texture,color:.clear,size:texture.size())
        self.size = self.size
        self.position = CGPoint(x:xPos,y:self.frame.height/2)
        self.zPosition = 0
        self.name = "bg"
        let move = SKAction.moveBy(x: -self.frame.width*2, y: 0, duration: 60)
        let remove = SKAction.removeFromParent()
        let action = SKAction.sequence([move,remove])
        self.run(action)
    }
    
    init(){
        self.myScene = SKScene()
        let texture = SKTexture(imageNamed: "Wall")
        super.init(texture:texture,color:.clear,size:texture.size())
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
