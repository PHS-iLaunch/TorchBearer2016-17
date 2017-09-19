//
//  Bullet.swift
//  TorchBearer
//
//  Created by Robert Zhang on 12/31/16.
//  Copyright © 2016 Robert Zhang. All rights reserved.
//

import SpriteKit

class Bullet:SKSpriteNode{
    var myScene:SKScene
    var passed:Bool = false
    var light:SKLightNode = SKLightNode()
    var emitter:SKEmitterNode = SKEmitterNode()
    
    init(scene:SKScene){
        self.myScene = scene
        let texture = SKTexture(imageNamed: "Bullet")
        super.init(texture:texture,color:.clear,size:texture.size())
        self.setScale(0.07)
        self.zPosition = 4
        self.position = makePosition()
        self.name = "bullet"
        setPhysics()
        action()
        lighting()
        emitterMake()
        
        self.lightingBitMask = PhysicsMasks.Light
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makePosition()->CGPoint{
        let range = UInt32(myScene.frame.height-myScene.frame.height/GameConstants.ceilingHeightConstant-myScene.frame.height/GameConstants.floorHeightConstant-self.size.height)
        let heightAdd = GameConstants.floorHeightConstant+self.size.height/2
        let randy:CGFloat = CGFloat(arc4random_uniform(range))+heightAdd
        return CGPoint(x:myScene.frame.width*1.5,y:randy)
    }
    
    func setPhysics(){
        self.physicsBody = SKPhysicsBody(rectangleOf: self.size)
        self.physicsBody?.isDynamic = false
        self.physicsBody?.friction = 0
        self.physicsBody?.categoryBitMask = PhysicsMasks.Bullet
        self.physicsBody?.collisionBitMask = PhysicsMasks.Ninja
        self.physicsBody?.contactTestBitMask = PhysicsMasks.Ninja
    }
    
    func action(){
        let move = SKAction.moveBy(x: -myScene.frame.width*3, y: 0, duration: 3)
        let remove = SKAction.removeFromParent()
        let action = SKAction.sequence([move,remove])
        self.run(action)
        
        let jiggle1 = SKAction.rotate(toAngle: CGFloat(M_PI)*0.1, duration: 0.2)
        let jiggle2 = SKAction.rotate(toAngle: -CGFloat(M_PI)*0.1, duration: 0.2)
        let jiggle = SKAction.sequence([jiggle1,jiggle2])
        let jiggling = SKAction.repeatForever(jiggle)
        self.run(jiggling)
    }
    
    func lighting(){
        light.position = CGPoint(x:self.position.x,y:0)
        light.isEnabled = true
        light.categoryBitMask = PhysicsMasks.Light
        light.falloff = 2
        light.shadowColor = UIColor(red:0,green:0,blue:0,alpha:0.1)
        light.lightColor = .orange
        light.ambientColor = .black
        light.zPosition = 4
        self.addChild(light)
    }
    
    func emitterMake(){
        emitter = SKEmitterNode(fileNamed: "BulletFlame")!
        emitter.position = CGPoint(x:500,y:0)
        emitter.targetNode = myScene
        emitter.setScale(5)
        emitter.zPosition = 4
        emitter.particleZPosition = 4
        self.addChild(emitter)
    }
}
