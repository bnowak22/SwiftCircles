//
//  GameCircle.swift
//  SwiftCircles
//
//  Created by bnowak on 5/5/15.
//  Copyright (c) 2015 DoomDuck Studios. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class GameCircle {
    
    var mainCircle: SKShapeNode = SKShapeNode(circleOfRadius: 0)
    var innerCircle: SKShapeNode = SKShapeNode(circleOfRadius: 0)
    var randomPosition: CGPoint = CGPoint(x: 0, y: 0)
    
    func initWithRadius(radius: Int) {
    
        //set up circle sizes
        self.mainCircle = SKShapeNode(circleOfRadius: CGFloat(radius))
        self.innerCircle = SKShapeNode(circleOfRadius: 0)
        
        //set up position
        self.randomPosition = randomCoords()
        self.mainCircle.position = self.randomPosition
        self.innerCircle.position = self.randomPosition
        
        //set other attributes
        self.mainCircle.strokeColor = SKColor.blackColor()
        self.innerCircle.strokeColor = SKColor.blackColor()
        self.mainCircle.glowWidth = 1.0
        self.innerCircle.glowWidth = 1.0
        
        self.mainCircle.fillColor = SKColor.blueColor()
        self.innerCircle.fillColor = SKColor.orangeColor()
    }
    
    func randomCoords() -> CGPoint {
        
        var viewWidth = UIScreen.mainScreen().bounds.width
        var viewHeight = UIScreen.mainScreen().bounds.height
        
        let xBound = Int(viewWidth) - (2*CIRCLE_RADIUS)
        let yBound = Int(viewHeight) - (2*CIRCLE_RADIUS)
        
        let x = Int(arc4random_uniform(UInt32(xBound))) + CIRCLE_RADIUS
        let y = Int(arc4random_uniform(UInt32(yBound))) + CIRCLE_RADIUS
        
        let circlePos = CGPointMake(CGFloat(x), CGFloat(y))
        return circlePos
    }
    
}
