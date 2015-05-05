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

class GameCircle: SKShapeNode {
    
    //this circle's radius
    var radius: CGFloat = 0.0
    
    //create inner circle
    var innerRadius: CGFloat = 0.0
    var innerCircle: SKShapeNode = SKShapeNode(circleOfRadius: 0)
    
    //collision bitmask
    let mainCircleCategory:UInt32 = 0x1 << 0
    
    //expanding bool
    var shouldExpand = false
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //custom init
    init(circleOfRadius: CGFloat) {
        
        super.init()
        
        //set radius
        self.radius = circleOfRadius
        
        //enable touches
        self.userInteractionEnabled = true
    
        //set up circle sizes
        self.innerCircle = SKShapeNode(circleOfRadius: circleOfRadius)
        self.path = innerCircle.path
        self.innerCircle = SKShapeNode(circleOfRadius: 0.0)
        
        //set up position
        self.position = randomCoords()
        
        //set up collision bitmasks
        self.physicsBody = SKPhysicsBody(circleOfRadius: circleOfRadius, center: self.position)
        self.physicsBody?.categoryBitMask = self.mainCircleCategory
        self.physicsBody?.contactTestBitMask = self.mainCircleCategory
        
        //set other attributes
        self.strokeColor = SKColor.blackColor()
        self.glowWidth = 0.25
        self.fillColor = UIColor(red: 175/255, green: 158/255, blue: 217/255, alpha: 1.0)
    }
    
    //get random coordinates on screen
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
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        for touch in (touches as! Set<UITouch>) {
            self.shouldExpand = true
            var gameParent: GameScene = self.scene as! GameScene
            gameParent.expandCircle(self)
        }
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        for touch in (touches as! Set<UITouch>) {
            println("Touch ended!")
            self.shouldExpand = false
            
            //calculate radius difference for score
            var points = abs(self.radius - self.innerRadius)
            
            //update score
            var gameParent: GameScene = self.scene as! GameScene
            gameParent.score = gameParent.score + Double(points)
            
            //remove circle from screen
            self.innerCircle.removeFromParent()
            self.removeFromParent()
            
            //let parent know to draw another circle
            gameParent.shouldDrawCircle = true
            
        }
    }
}
