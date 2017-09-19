//
//  GameConstants.swift
//  TorchBearer
//
//  Created by Robert Zhang on 12/31/16.
//  Copyright © 2016 Robert Zhang. All rights reserved.
//
import SpriteKit
class GameConstants{
    static let floorHeightConstant:CGFloat = 10 //self.frame.height/10
    static let ceilingHeightConstant:CGFloat = 20 //self.frame.height/20
}

class toSave{
    static var totalCash = 0
    static var highScore = 0
}

struct PhysicsMasks{
    static let Ninja:UInt32 = 0x1<<1
    static let Ground:UInt32 = 0x1<<2
    static let Ceiling:UInt32 = 0x1<<3
    static let Light:UInt32 = 0x1<<4
    static let Bullet:UInt32 = 0x1<<5
    static let Coin:UInt32 = 0x1<<6
}
