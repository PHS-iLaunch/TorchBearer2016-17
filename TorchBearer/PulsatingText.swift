//
//  PulsatingText.swift
//  TorchBearer
//
//  Created by Robert Zhang on 1/1/17.
//  Copyright © 2017 Robert Zhang. All rights reserved.
//

import UIKit
import SpriteKit

class PulsatingText : SKLabelNode {
    
    func setTextFontSizeAndPulsate(_ theText: String, theFontSize: CGFloat){
        self.text = theText;
        self.fontSize = theFontSize
        let scaleSequence = SKAction.sequence([SKAction.scale(to: 1.1, duration: 0.5),SKAction.scale(to: 1.0, duration:0.7)])
        let scaleForever = SKAction.repeatForever(scaleSequence)
        self.run(scaleForever)
    }
}

