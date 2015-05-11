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

class GameViewController: UIViewController, ADBannerViewDelegate {

    @IBOutlet weak var adBannerView: ADBannerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //support for banner ads
        self.canDisplayBannerAds = true
        self.adBannerView?.delegate = self
        self.adBannerView?.alpha = 0
        self.adBannerView.layer.zPosition = 2
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    
        let skView = self.originalContentView as! SKView
        if skView.scene == nil {
            if let scene = GameScene.unarchiveFromFile("GameScene") as? GameScene {
                // Configure the view
                let skView = self.originalContentView as! SKView
                
                /* Sprite Kit applies additional optimizations to improve rendering performance */
                skView.ignoresSiblingOrder = true
                
                /* Set the scale mode to scale to fit the window */
                scene.size = skView.bounds.size
                scene.scaleMode = .AspectFill
                
                scene.viewController = self
                
                skView.presentScene(scene)
            }
        }
    }
    
    //banner add support
    
    func bannerViewWillLoadAd(banner: ADBannerView!) {
        
    }
    
    func bannerViewDidLoadAd(banner: ADBannerView!) {
        //add banner view if it's not there
        println("Succesfully retrieved ad")
        self.adBannerView.alpha = 1
    }
    
    func bannerViewActionShouldBegin(banner: ADBannerView!, willLeaveApplication willLeave: Bool) -> Bool {
        return true
    }
    
    func bannerViewActionDidFinish(banner: ADBannerView!) {
        
    }
    
    func bannerView(banner: ADBannerView!, didFailToReceiveAdWithError error: NSError!) {
        println("Failed to receive ad")
        self.adBannerView.alpha = 0
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


