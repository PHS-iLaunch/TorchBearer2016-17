//
//  Coin.swift
//  TorchBearer
//
//  Created by Robert Zhang on 1/1/17.
//  Copyright © 2017 Robert Zhang. All rights reserved.
//

import SpriteKit
import GameplayKit

class Coin:SKSpriteNode{
    var myScene:SKScene
    var value:Int = 1
    init(scene:SKScene){
        let texture:SKTexture = SKTexture(imageNamed:"Coin1")
        self.myScene = scene
        super.init(texture:texture,color:.clear,size:texture.size())
        self.zPosition = 3
        self.name = "coin"
        self.setScale(0.2)
        self.position = makePosition()
        self.lightingBitMask = PhysicsMasks.Light
        self.value = setValue()
        action()
        animate()
        setPhysics()
    }
    
    init(){
        self.myScene = SKScene()
        let texture = SKTexture(imageNamed: "Coin1")
        super.init(texture:texture,color:.clear,size:texture.size())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    ///
    func setValue()->Int{
        let random = GKRandomSource()
        let value = GKGaussianDistribution(randomSource: random, lowestValue:1, highestValue: 5)
        return value.nextInt()
    }
    
    func makePosition()->CGPoint{
        let range = UInt32(myScene.frame.height-myScene.frame.height/GameConstants.ceilingHeightConstant-myScene.frame.height/GameConstants.floorHeightConstant-self.size.height)
        let heightAdd = GameConstants.floorHeightConstant+self.size.height/2
        let randy:CGFloat = CGFloat(arc4random_uniform(range))+heightAdd
        return CGPoint(x:myScene.frame.width*1.5,y:randy)
    }
    
    func action(){
        let move = SKAction.moveBy(x: -myScene.frame.width*3, y: 0, duration: 9)
        let remove = SKAction.removeFromParent()
        let action = SKAction.sequence([move,remove])
        self.run(action)
    }
    
    func animate(){
        let t1:SKTexture = SKTexture(imageNamed:"Coin1")
        let t2:SKTexture = SKTexture(imageNamed:"Coin2")
        let t3:SKTexture = SKTexture(imageNamed:"Coin3")
        let t4:SKTexture = SKTexture(imageNamed:"Coin4")
        let t5:SKTexture = SKTexture(imageNamed:"Coin5")
        let t6:SKTexture = SKTexture(imageNamed:"Coin6")
        let array:[SKTexture] = [t1,t2,t3,t4,t5,t6]
        let walk:SKAction = SKAction.animate(with:array,timePerFrame:0.06)
        let walkOn:SKAction = SKAction.repeatForever(walk)
        self.run(walkOn)
        self.zRotation = 0
    }
    
    func setPhysics(){
        self.physicsBody = SKPhysicsBody(texture: self.texture!, size: self.size)
        self.physicsBody?.isDynamic = false
        self.physicsBody?.categoryBitMask = PhysicsMasks.Coin
        self.physicsBody?.contactTestBitMask = PhysicsMasks.Ninja
        
        self.physicsBody?.restitution = 0
        self.physicsBody?.friction = 0
    }
}
