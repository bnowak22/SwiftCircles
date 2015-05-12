//
//  GameScene.swift
//  SwiftCircles
//
//  Created by bnowak on 4/27/15.
//  Copyright (c) 2015 DoomDuck Studios. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    //get view controller
    var viewController: GameViewController?
    
    //scoring
    var scoreLabel = SKLabelNode()
    var deltaLabel = SKLabelNode()
    var delta = 0.0
    var circleScore = 0
    var progressBar = CirclesProgressBar()
    
    //perfection bonus support
    var perfectLabel = SKLabelNode()
    var wasPerfect = false
    var wasPreviouslyPerfect = false
    var perfectFills = 0
    var concurrentPerfectFills = 0
    var hiConcurrentPerfectFills = 0

    //hiscore support
    let defaults = NSUserDefaults.standardUserDefaults()
    
    //toggle to draw circle
    var shouldDrawCircle = true
    
    //keeping track of circles on screen
    var circles = [GameCircle]()
    
    override func didMoveToView(view: SKView) {
        
        //set background color
        backgroundColor = GAME_BACKGROUND_COLOR
        
        //set up score label
        scoreLabel.text = String(circleScore)
        scoreLabel.fontSize = 36
        scoreLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:self.frame.height - 35)
        self.addChild(scoreLabel)
        
        //set up progress bar
        progressBar.position = CGPoint(x:CGRectGetMidX(self.frame), y:self.frame.height - 50)
        self.addChild(progressBar)
        
        //set up perfect label
        perfectLabel.text = "Perfect!"
        perfectLabel.fontSize = 26
        perfectLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:self.frame.height - 90)
        perfectLabel.alpha = 0  //makes it transparent
        self.addChild(perfectLabel)
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
                circle.innerCircle.fillColor = circle.innerCircleColor
                
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
        if (wasPerfect) {
            perfectFills++
            if wasPreviouslyPerfect || hiConcurrentPerfectFills == 0 {
                concurrentPerfectFills++
                if (concurrentPerfectFills > hiConcurrentPerfectFills) {
                    hiConcurrentPerfectFills = concurrentPerfectFills
                }
            }
            perfectLabel.alpha = 1
            perfectLabel.runAction(SKAction.fadeOutWithDuration(PERFECT_MESSAGE_FADE_TIME))
            wasPerfect = false
            wasPreviouslyPerfect = true
        }
        else {
            wasPreviouslyPerfect = false
            concurrentPerfectFills = 0
        }
        
        deltaLabel.text = String(format: "%.1f", delta)
        progressBar.setProgress(CGFloat(delta/100))
        scoreLabel.text = String(circleScore)
        
        //check for end game
        if (delta > 100) {
            self.scene!.view?.paused = true
            shouldDrawCircle = false
            endGame()
        }
    }
    
    func endGame() {
        
        //save current score
        defaults.setObject(String(format: "%i", circleScore), forKey: CURRENT_SCORE_KEY)
        defaults.setObject(String(format: "%i", perfectFills), forKey: PERFECT_FILLS_KEY)
        defaults.setObject(String(format: "%i", hiConcurrentPerfectFills), forKey: CONCURRENT_PERFECT_FILLS_KEY)
        
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
        
        //break down scene
        self.removeAllChildren()
        
        //display results page
        self.viewController!.performSegueWithIdentifier("endGameSegue", sender: nil)
    }
}
