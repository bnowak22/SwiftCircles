//
//  GameViewController.swift
//  SwiftCircles
//
//  Created by bnowak on 4/27/15.
//  Copyright (c) 2015 DoomDuck Studios. All rights reserved.
//

import UIKit
import SpriteKit
import iAd

extension SKNode {
    class func unarchiveFromFile(file : String) -> SKNode? {
        if let path = NSBundle.mainBundle().pathForResource(file, ofType: "sks") {
            var sceneData = NSData(contentsOfFile: path, options: .DataReadingMappedIfSafe, error: nil)!
            var archiver = NSKeyedUnarchiver(forReadingWithData: sceneData)
            
            archiver.setClass(self.classForKeyedUnarchiver(), forClassName: "SKScene")
            let scene = archiver.decodeObjectForKey(NSKeyedArchiveRootObjectKey) as! GameScene
            archiver.finishDecoding()
            return scene
        } else {
            return nil
        }
    }
}

class GameViewController: UIViewController {

    var skView = SKView()
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        self.skView = self.originalContentView as! SKView
        if self.skView.scene == nil {
            if let scene = GameScene.unarchiveFromFile("GameScene") as? GameScene {
                // Configure the view
                self.skView = self.originalContentView as! SKView
                
                /* Sprite Kit applies additional optimizations to improve rendering performance */
                self.skView.ignoresSiblingOrder = true
                
                /* Set the scale mode to scale to fit the window */
                scene.size = skView.bounds.size
                scene.scaleMode = .AspectFill
                
                scene.viewController = self
                
                self.skView.presentScene(scene)
            }
        }
    }
    
    //interstitial add support
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "endGameSegue" {
            let destination = segue.destinationViewController as! UIViewController
            destination.interstitialPresentationPolicy = ADInterstitialPresentationPolicy.Automatic
        }
    }

    override func shouldAutorotate() -> Bool {
        return true
    }

    override func supportedInterfaceOrientations() -> Int {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return Int(UIInterfaceOrientationMask.AllButUpsideDown.rawValue)
        } else {
            return Int(UIInterfaceOrientationMask.All.rawValue)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}


