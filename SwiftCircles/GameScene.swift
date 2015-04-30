//
//  GameScene.swift
//  SwiftCircles
//
//  Created by bnowak on 4/27/15.
//  Copyright (c) 2015 DoomDuck Studios. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var currentFrames = 0
    var drawFrames = 60
    var shouldDrawCircle = true
    
    override func didMoveToView(view: SKView) {
        
        //set up score label
        let scoreLabel = SKLabelNode()
        scoreLabel.text = "0"
        scoreLabel.fontSize = 36;
        scoreLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:self.frame.height - 40)
        self.addChild(scoreLabel)
        
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
//        for touch in (touches as! Set<UITouch>) {
//            let location = touch.locationInNode(self)
//            
//            let sprite = SKSpriteNode(imageNamed:"Spaceship")
//            
//            sprite.xScale = 0.5
//            sprite.yScale = 0.5
//            sprite.position = location
//            
//            let action = SKAction.rotateByAngle(CGFloat(M_PI), duration:1)
//            
//            sprite.runAction(SKAction.repeatActionForever(action))
//            
//            self.addChild(sprite)
//        }
        
        
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        
        currentFrames++
        
        if (currentFrames == drawFrames) {
            drawCircle()
            currentFrames = 0
        }
        
    }
    
    func drawCircle() {
        
        //init circle
        var newCircle = SKShapeNode(circleOfRadius: CGFloat(CIRCLE_RADIUS)) // Size of Circle
        newCircle.strokeColor = SKColor.blackColor()
        newCircle.glowWidth = 1.0
        newCircle.fillColor = SKColor.orangeColor()
        
        //calculate random x and y for circle position
        //newCircle.position = randomCoords()
        newCircle.position = CGPointMake(CGFloat(0), CGFloat(0))
        
        //add circle
        self.addChild(newCircle)
    }
    
    func randomCoords() -> CGPoint {
        
        let xBound = Int(self.frame.width) - (2*CIRCLE_RADIUS)
        let yBound = Int(self.frame.height) - (2*CIRCLE_RADIUS)
        
        let x = Int(arc4random_uniform(UInt32(xBound))) + CIRCLE_RADIUS
        let y = Int(arc4random_uniform(UInt32(yBound))) + CIRCLE_RADIUS
        
        let circlePos = CGPointMake(CGFloat(x), CGFloat(y))
        return circlePos
    }
}
