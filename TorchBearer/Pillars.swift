//
//  Pillars.swift
//  TorchBearer
//
//  Created by Robert Zhang on 12/31/16.
//  Copyright © 2016 Robert Zhang. All rights reserved.
//

import SpriteKit

class Pillar:SKSpriteNode{
    var myScene:SKScene
    init(scene:SKScene){
        self.myScene = scene
        let texture = SKTexture(imageNamed: "Pillars")
        super.init(texture:texture,color:.clear,size:texture.size())
        self.size = CGSize(width:scene.frame.width,height:scene.frame.height-scene.frame.height/GameConstants.ceilingHeightConstant-scene.frame.height/GameConstants.floorHeightConstant)
        self.zPosition = 2
        self.name = "pillars"
        self.position = CGPoint(x:scene.frame.width/2,y:scene.frame.height/GameConstants.floorHeightConstant+self.size.height/2)
        makeAction(true)
        
        self.lightingBitMask = PhysicsMasks.Light
        self.shadowCastBitMask = PhysicsMasks.Light
    }
    init(scene:SKScene, xPos:CGFloat){
        self.myScene = scene
        let texture = SKTexture(imageNamed: "Pillars")
        super.init(texture:texture,color:.clear,size:texture.size())
         self.size = CGSize(width:scene.frame.width,height:scene.frame.height-scene.frame.height/GameConstants.ceilingHeightConstant-scene.frame.height/GameConstants.floorHeightConstant)
        self.zPosition = 2
        self.name = "pillars"
        self.position = CGPoint(x:xPos,y:scene.frame.height/GameConstants.floorHeightConstant+self.size.height/2)
        makeAction(false)
        
        self.lightingBitMask = PhysicsMasks.Light
    }
    
    init(){
        self.myScene = SKScene()
        let texture = SKTexture(imageNamed: "Pillars")
        super.init(texture:texture,color:.clear,size:texture.size())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeAction(_ first:Bool){
        let move:SKAction
        if first{
            move = SKAction.moveBy(x: -myScene.frame.width, y: 0, duration: 3)
        }else{
            move = SKAction.moveBy(x: -myScene.frame.width*2, y: 0, duration: 6)
        }
        let remove = SKAction.removeFromParent()
        let action = SKAction.sequence([move,remove])
        self.run(action)
    }

}
