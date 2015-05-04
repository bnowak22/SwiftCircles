//
//  GameScene.swift
//  SwiftCircles
//
//  Created by bnowak on 4/27/15.
//  Copyright (c) 2015 DoomDuck Studios. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var totalFrames = 0
    var currentFrames = 0
    var initialDrawFrames = 120
    var drawFrames = 0
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
//            println(location)
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
        
        totalFrames++
        currentFrames++
        
        if (drawFrames == 0) {
            if (currentFrames == initialDrawFrames) {
                currentFrames = 0
                drawCircle()
            }
        }
        else {
            if (currentFrames == drawFrames) {
                currentFrames = 0
                drawCircle()
            }
        }
        
        
    }
    
    func drawCircle() {
        
        //init circle
        var newCircle = SKShapeNode(circleOfRadius: CGFloat(CIRCLE_RADIUS)) // Size of Circle
        newCircle.strokeColor = SKColor.blackColor()
        newCircle.glowWidth = 1.0
        newCircle.fillColor = SKColor.orangeColor()
        
        //calculate random x and y for circle position
        newCircle.position = randomCoords()
        
        //add circle
        self.addChild(newCircle)
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
    
    func randomDrawFrames() {
        //need more logic in here to scale this based on passed frames (shorter as game goes on)
        drawFrames = Int(arc4random_uniform(300)) + 60
    }
}
