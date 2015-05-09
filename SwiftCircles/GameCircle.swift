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
import AVFoundation

class GameCircle: SKShapeNode {
    
    //this circle's radius
    var radius: CGFloat = 0.0
    
    //create inner circle
    var innerRadius: CGFloat = 0.0
    var innerCircle: SKShapeNode = SKShapeNode(circleOfRadius: 0)
    
    //expanding bool
    var shouldExpand = false
    var growRate: CGFloat = 1.0
    
    //circle colors
    var circleColors = [UIColor](arrayLiteral: UIColor.greenColor(), UIColor.redColor(), UIColor.blueColor(), UIColor.yellowColor(), UIColor.magentaColor(), UIColor.orangeColor(), UIColor.purpleColor(), UIColor.cyanColor())
    var mainCircleColor = UIColor()
    var innerCircleColor = UIColor()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //custom init
    override init() {
        
        super.init()
        
        //set radius
        self.radius = randomBetweenNumbers(CGFloat(MIN_CIRCLE_RADIUS), secondNum: CGFloat(MAX_CIRCLE_RADIUS))
        
        //enable touches
        self.userInteractionEnabled = true
        
        //set up colors
        randomColors()
    
        //set up circle sizes
        self.innerCircle = SKShapeNode(circleOfRadius: self.radius)
        self.path = innerCircle.path
        self.innerCircle = SKShapeNode(circleOfRadius: 0.0)
        
        //set up position
        self.position = randomCoords()
        
        //set other attributes
        self.strokeColor = SKColor.whiteColor()
        self.glowWidth = 0.25
        self.fillColor = mainCircleColor
        
        //calculate random grow rate
        self.growRate = randomBetweenNumbers(CGFloat(MIN_GROW_RATE), secondNum: CGFloat(MAX_GROW_RATE))
    }
    
    //get random coordinates on screen
    func randomCoords() -> CGPoint {
        
        var viewWidth = UIScreen.mainScreen().bounds.width
        var viewHeight = UIScreen.mainScreen().bounds.height
        
        let xBound = viewWidth - (2*self.radius)
        let yBound = viewHeight - (2*self.radius) - 60  //leave room for scoring info on top
        
        let x = randomBetweenNumbers(self.radius, secondNum: xBound)
        let y = randomBetweenNumbers(self.radius + CGFloat(BANNER_AD_HEIGHT), secondNum: yBound)
        
        let circlePos = CGPointMake(CGFloat(x), CGFloat(y))
        return circlePos
    }
    
    //set random colors for circle
    func randomColors() {
        var mainIndex = Int(arc4random_uniform(UInt32(circleColors.count)))
        var innerIndex = Int(arc4random_uniform(UInt32(circleColors.count)))
        while mainIndex == innerIndex {
            innerIndex = Int(arc4random_uniform(UInt32(circleColors.count)))
        }
        innerCircleColor = circleColors[innerIndex]
        mainCircleColor = circleColors[mainIndex]
    }
    
    //random decimal in ranges
    func randomBetweenNumbers(firstNum: CGFloat, secondNum: CGFloat) -> CGFloat{
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum)
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        for touch in (touches as! Set<UITouch>) {
            self.shouldExpand = true
            var gameParent: GameScene = self.scene as! GameScene
        }
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        for touch in (touches as! Set<UITouch>) {

            self.shouldExpand = false
            
            //get scene
            var gameParent: GameScene = self.scene as! GameScene
            
            //calculate radius difference for score
            var newDelta = abs(self.radius - self.innerRadius)
            
            //if difference is small, award "perfect" bonus and make delta negative
            if newDelta <= CGFloat(PERFECT_DELTA) {
                println("Perfect")
                gameParent.wasPerfect = true
                gameParent.delta = gameParent.delta + PERFECT_BONUS
            }
            //else, just update as normal
            else {
                //update score
                gameParent.delta = gameParent.delta + Double(newDelta)
            }
            
            gameParent.circleScore = gameParent.circleScore + 1
            
            //remove circle from screen
            self.innerCircle.removeFromParent()
            self.removeFromParent()
            
            //remove circle from circles array
            gameParent.circles.removeLast()
            
            //let parent know to draw another circle
            gameParent.shouldDrawCircle = true
            
        }
    }
}
