//
//  SpriteNodeExtension.swift
//  TorchBearer
//
//  Created by Robert Zhang on 1/5/17.
//  Copyright © 2017 Robert Zhang. All rights reserved.
//

import SpriteKit

extension SKSpriteNode{
    func pulsate(){
        let increase = SKAction.scale(to: 1.1, duration: 0.5)
        let decrease = SKAction.scale(to:0.9,duration:0.5)
        let sequence = SKAction.sequence([increase,decrease])
        let on = SKAction.repeatForever(sequence)
        self.run(on)
    }
}
