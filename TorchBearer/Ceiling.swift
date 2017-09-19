//
//  Ceiling.swift
//  TorchBearer
//
//  Created by Robert Zhang on 12/31/16.
//  Copyright © 2016 Robert Zhang. All rights reserved.
//

import SpriteKit

class Ceiling:SKSpriteNode{
    var myScene:SKScene
    init(scene:SKScene){
        self.myScene = scene
        let texture = SKTexture(imageNamed: "Ground")
        super.init(texture:texture,color:.clear,size:texture.size())
        self.size = CGSize(width:scene.frame.width,height:scene.frame.height/GameConstants.ceilingHeightConstant)
        self.zPosition = 2
        self.name = "ceiling"
        self.position = CGPoint(x:scene.frame.width/2,y:scene.frame.height-self.size.height/2)
        setPhysics()
        makeAction(true)
        
        self.lightingBitMask = PhysicsMasks.Light
        self.shadowCastBitMask = PhysicsMasks.Light

    }
    init(scene:SKScene, xPos:CGFloat){
        self.myScene = scene
        let texture = SKTexture(imageNamed: "Ground")
        super.init(texture:texture,color:.clear,size:texture.size())
        self.size = CGSize(width:scene.frame.width,height:scene.frame.height/GameConstants.ceilingHeightConstant)
        self.zPosition = 2
        self.name = "ceiling"
        self.position = CGPoint(x:xPos,y:scene.frame.height-self.size.height/2)
        setPhysics()
        makeAction(false)
        
        self.lightingBitMask = PhysicsMasks.Light
        self.shadowCastBitMask = PhysicsMasks.Light

    }
    
    init(){
        self.myScene = SKScene()
        let texture = SKTexture(imageNamed: "Ground")
        super.init(texture:texture,color:.clear,size:texture.size())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setPhysics(){
        self.physicsBody = SKPhysicsBody(rectangleOf: self.size)
        self.physicsBody?.isDynamic = false
        self.physicsBody?.friction = 0
        self.physicsBody?.categoryBitMask = PhysicsMasks.Ceiling
        self.physicsBody?.collisionBitMask = PhysicsMasks.Ninja
        self.physicsBody?.contactTestBitMask = PhysicsMasks.Ninja
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
