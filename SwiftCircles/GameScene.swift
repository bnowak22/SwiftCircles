//
//  GameScene.swift
//  SwiftCircles
//
//  Created by bnowak on 4/27/15.
//  Copyright (c) 2015 DoomDuck Studios. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var totalFrames = 0
    var currentFrames = 0
    var drawFrames = 120
    var shouldDrawCircle = true
    
    var circles = [GameCircle]()
    
    override func didMoveToView(view: SKView) {
        
        //set up score label
        let scoreLabel = SKLabelNode()
        scoreLabel.text = "0"
        scoreLabel.fontSize = 36;
        scoreLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:self.frame.height - 40)
        self.addChild(scoreLabel)
        
        //remove gravity
        self.physicsWorld.gravity = CGVectorMake(0, 0)
        
        //set contact delegate
        self.physicsWorld.contactDelegate = self
        
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
        
        if (currentFrames == drawFrames) {
            //reset current frames
            //currentFrames = 0
            
            //init circle
            var newCircle  = GameCircle(circleOfRadius: CGFloat(CIRCLE_RADIUS))
            
            //add circle to array
            circles.append(newCircle)
            
            //add circle to screen
            self.addChild(newCircle)
        }
        
    }
    
    
    //collision
    func didBeginContact(contact: SKPhysicsContact) {
        println("collision")
        //contact.bodyA.node?.removeFromParent()
    }
    
    //resizing of circle
    func expandCircle(GameCircle) {
        println("Starting to expand!")
    }
    
    func randomDrawFrames() {
        //need more logic in here to scale this based on passed frames (shorter as game goes on)
        self.drawFrames = Int(arc4random_uniform(300)) + 60
    }
}
