//
//  CirclesProgressBar.swift
//  SwiftCircles
//
//  Created by bnowak on 5/5/15.
//  Copyright (c) 2015 DoomDuck Studios. All rights reserved.
//

import Foundation
import SpriteKit
class CirclesProgressBar: SKCropNode {
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init() {
        
        super.init()
        
        self.maskNode  = SKSpriteNode(color: SKColor .whiteColor(), size: CGSizeMake(UIScreen.mainScreen().bounds.width,20))
        var bar: SKSpriteNode = SKSpriteNode(color: PROGRESS_BAR_COLOR, size: CGSizeMake(UIScreen.mainScreen().bounds.width,20))
        self.addChild(bar)
    }
    
    func setProgress(progress: CGFloat) {
        self.maskNode?.xScale = progress
    }
}