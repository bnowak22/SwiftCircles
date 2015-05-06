//
//  GameScene.swift
//  SwiftCircles
//
//  Created by bnowak on 4/27/15.
//  Copyright (c) 2015 DoomDuck Studios. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    //get view controller
    var viewController: GameViewController?
    
    //scoring
    var scoreLabel = SKLabelNode()
    var deltaLabel = SKLabelNode()
    var delta = 0.0
    var circleScore = 0
    var progressBar = CirclesProgressBar()

    //hiscore support
    let defaults = NSUserDefaults.standardUserDefaults()
    
    //toggle to draw circle
    var shouldDrawCircle = true
    
    //keeping track of circles on screen
    var circles = [GameCircle]()
    
    override func didMoveToView(view: SKView) {
        
        //set background color
        backgroundColor = BACKGROUND_COLOR
        
        //set up score label
        scoreLabel.text = String(circleScore)
        scoreLabel.fontSize = 36;
        scoreLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:self.frame.height - 35)
        self.addChild(scoreLabel)
        
        //set up progress bar
        progressBar.position = CGPoint(x:CGRectGetMidX(self.frame), y:self.frame.height - 50)
        self.addChild(progressBar)
        
        //remove gravity
        self.physicsWorld.gravity = CGVectorMake(0, 0)
        
        //set contact delegate
        self.physicsWorld.contactDelegate = self
        
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        
        //expand circles if we need to
        for circle in circles {
            if circle.shouldExpand {
                
                //remove and re-draw circle
                circle.innerCircle.removeFromParent()
                
                //increment radius (growth rate)
                circle.innerRadius = circle.innerRadius + CGFloat(circle.growRate)
                
                //create new circle
                circle.innerCircle = SKShapeNode(circleOfRadius: CGFloat(circle.innerRadius))
                circle.innerCircle.position = circle.position
                circle.innerCircle.strokeColor = SKColor.whiteColor()
                circle.innerCircle.glowWidth = 0.25
                circle.innerCircle.fillColor = CIRCLE_INNER_COLOR
                
                //add circle to view
                self.addChild(circle.innerCircle)
            }
            else {
                //fill up bar during idle play
                delta = delta + TIME_PENALTY
                progressBar.setProgress(CGFloat(delta/100))
            }
        }
        
        //draw circle if we need to
        if (shouldDrawCircle) {
            
            //init circle
            var newCircle  = GameCircle()
            
            //add circle to array
            circles.append(newCircle)
            
            //add circle to screen
            self.addChild(newCircle)
            
            shouldDrawCircle = false
        }
        
        //update score
        deltaLabel.text = String(format: "%.1f", delta)
        progressBar.setProgress(CGFloat(delta/100))
        scoreLabel.text = String(circleScore)
        
        //check for end game
        if (delta > 100) {
            self.scene!.view?.paused = true
            shouldDrawCircle = false
            self.removeAllChildren()
            endGame()
        }
        
    }
    
    func endGame() {
        
        //save current score
        defaults.setObject(String(format: "%i", circleScore), forKey: CURRENT_SCORE_KEY)
        
        //get score and hiscore
        if var hiScore = defaults.stringForKey(HI_SCORE_KEY) {
            if circleScore > hiScore.toInt() {
                defaults.setObject(String(format: "%i", circleScore), forKey: HI_SCORE_KEY)
            }
            else {
                //leave hi score as is
            }
        }
        else {
            defaults.setObject(String(format: "%i", circleScore), forKey: HI_SCORE_KEY)
        }
        
        //display results page
        self.viewController!.performSegueWithIdentifier("endGameSegue", sender: nil)
    }
    
    //collision
    func didBeginContact(contact: SKPhysicsContact) {
        println("collision")
    }
}
