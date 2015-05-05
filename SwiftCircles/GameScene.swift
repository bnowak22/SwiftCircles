//
//  GameScene.swift
//  SwiftCircles
//
//  Created by bnowak on 4/27/15.
//  Copyright (c) 2015 DoomDuck Studios. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    //scoring
    var scoreLabel = SKLabelNode()
    var score = 0.0
    
    //timing/drawing circles
    var totalFrames = 0
    var currentFrames = 0
    var drawFrames = 120
    var shouldDrawCircle = true
    
    //keeping track of circles on screen
    var circles = [GameCircle]()
    
    override func didMoveToView(view: SKView) {
        
        //set background color
        backgroundColor = UIColor(red: 66/255, green: 235/255, blue: 218/255, alpha: 1.0)
        
        //set up score label
        scoreLabel.text = NSString(format: "%.2f", score) as String
        scoreLabel.fontSize = 36;
        scoreLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:self.frame.height - 40)
        self.addChild(scoreLabel)
        
        //remove gravity
        self.physicsWorld.gravity = CGVectorMake(0, 0)
        
        //set contact delegate
        self.physicsWorld.contactDelegate = self
        
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        
        totalFrames++
        currentFrames++
        
        //expand circles if we need to
        for circle in circles {
            if circle.shouldExpand {
                //remove and re-draw circle
                circle.innerCircle.removeFromParent()
                circle.innerRadius = circle.innerRadius + 0.75 //grow rate
                
                //create new circle
                circle.innerCircle = SKShapeNode(circleOfRadius: CGFloat(circle.innerRadius))
                circle.innerCircle.position = circle.position
                circle.innerCircle.strokeColor = SKColor.blackColor()
                circle.innerCircle.glowWidth = 0.25
                circle.innerCircle.fillColor = UIColor(red: 7/255, green: 242/255, blue: 70/255, alpha: 1.0)
                
                //add circle to view
                self.addChild(circle.innerCircle)
            }
        }
        
        //draw circle if we need to
        if (shouldDrawCircle) {
            
            //init circle
            var newCircle  = GameCircle(circleOfRadius: CGFloat(CIRCLE_RADIUS))
            
            //add circle to array
            circles.append(newCircle)
            
            //add circle to screen
            self.addChild(newCircle)
            
            shouldDrawCircle = false
        }
        
        //update score
        scoreLabel.text = String(format: "%.1f", score)
        
    }
    
    
    //collision
    func didBeginContact(contact: SKPhysicsContact) {
        println("collision")
        //contact.bodyA.node?.removeFromParent()
    }
    
    //resizing of circle
    func expandCircle(newCircle: GameCircle) {
        println("Starting to expand!")
        self.addChild(newCircle.innerCircle)
    }
    
    func randomDrawFrames() {
        //need more logic in here to scale this based on passed frames (shorter as game goes on)
        self.drawFrames = Int(arc4random_uniform(300)) + 60
    }
}
