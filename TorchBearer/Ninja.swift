//
//  Ninja.swift
//  TorchBearer
//
//  Created by Robert Zhang on 12/31/16.
//  Copyright © 2016 Robert Zhang. All rights reserved.
//

import SpriteKit

class Ninja:SKSpriteNode{
    var myScene:SKScene
    var light:SKLightNode = SKLightNode()
    var booster:SKEmitterNode = SKEmitterNode()
    
    init(scene:SKScene){
        let texture:SKTexture = SKTexture(imageNamed:"1")
        self.myScene = scene
        super.init(texture:texture,color:.clear,size:texture.size())
        self.zPosition = 3
        self.name = "ninja"
        self.setScale(0.3)
        self.position = CGPoint(x:scene.frame.width/6+self.size.width/2,y:scene.frame.height/GameConstants.floorHeightConstant+self.size.height/2)
        animate()
        setPhysics()
        addLighting()
    }
    
    init(){
        self.myScene = SKScene()
        let texture = SKTexture(imageNamed: "1")
        super.init(texture:texture,color:.clear,size:texture.size())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    ///
    func animate(){
        let t1:SKTexture = SKTexture(imageNamed:"1")
        let t2:SKTexture = SKTexture(imageNamed:"2")
        let t3:SKTexture = SKTexture(imageNamed:"3")
        let t4:SKTexture = SKTexture(imageNamed:"4")
        let t5:SKTexture = SKTexture(imageNamed:"5")
        let t6:SKTexture = SKTexture(imageNamed:"6")
        let t7:SKTexture = SKTexture(imageNamed:"7")
        let t8:SKTexture = SKTexture(imageNamed:"8")
        let t9:SKTexture = SKTexture(imageNamed:"9")
        let t10:SKTexture = SKTexture(imageNamed:"10")
        let t11:SKTexture = SKTexture(imageNamed:"11")
        let t12:SKTexture = SKTexture(imageNamed:"12")
        let t13:SKTexture = SKTexture(imageNamed:"13")
        let t14:SKTexture = SKTexture(imageNamed:"14")
        let array:[SKTexture] = [t1,t2,t3,t4,t5,t6,t7,t8,t9,t10,t11,t12,t13,t14]
        let walk:SKAction = SKAction.animate(with:array,timePerFrame:0.04)
        let walkOn:SKAction = SKAction.repeatForever(walk)
        self.run(walkOn)
        self.zRotation = 0
    }
    
    func addLighting(){
        light.position = CGPoint(x:self.position.x,y:self.position.y+self.size.height/2)
        light.isEnabled = true
        light.categoryBitMask = PhysicsMasks.Light
        light.falloff = 1
        light.shadowColor = UIColor(red:0,green:0,blue:0,alpha:0.3)
        light.lightColor = .white
        light.ambientColor = .black
        light.zPosition = 4
        self.addChild(light)
        
        self.lightingBitMask = PhysicsMasks.Light
        self.shadowCastBitMask = PhysicsMasks.Light
    }
    
    func setPhysics(){
        self.physicsBody = SKPhysicsBody(texture: self.texture!, size: CGSize(width:self.size.width*0.8,height:self.size.height))
        self.physicsBody?.isDynamic = true
        self.physicsBody?.affectedByGravity = true
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.categoryBitMask = PhysicsMasks.Ninja
        self.physicsBody?.collisionBitMask = PhysicsMasks.Ceiling | PhysicsMasks.Ground | PhysicsMasks.Bullet
        self.physicsBody?.contactTestBitMask = PhysicsMasks.Ceiling | PhysicsMasks.Ground | PhysicsMasks.Bullet

        self.physicsBody?.restitution = 0
        self.physicsBody?.friction = 0
        
    }
    
    func thrust(){
        self.removeAllActions()
        self.zRotation = CGFloat(-M_PI/10.0)
        self.texture = SKTexture(imageNamed:"6")
        self.physicsBody?.velocity = CGVector(dx:0,dy:0)
        self.physicsBody?.applyImpulse(CGVector(dx:0,dy:30))
        
        booster = SKEmitterNode(fileNamed: "Booster")!
        booster.position = CGPoint(x:0,y:-self.frame.height*1.5)
        booster.zPosition = 2
        self.addChild(booster)
    }
    
    func noThrust(){
        self.removeAllActions()
        for node in self.children{
            if node.name == "Booster"{
                node.removeFromParent()
            }
        }
        self.zRotation = 0
        self.texture = SKTexture(imageNamed:"11")
    }
}
