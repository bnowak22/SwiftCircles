//
//  EndGameViewController.swift
//  SwiftCircles
//
//  Created by bnowak on 5/5/15.
//  Copyright (c) 2015 DoomDuck Studios. All rights reserved.
//

import Foundation
import UIKit
import GameKit
import iAd

//BUG:  Transition to GameScene, bar filled, score 0, no circles
//REPRODUCE: Tap interstitial ad, second add shows up, close this add and the bug occurs

class EndGameViewController: UIViewController, GKGameCenterControllerDelegate, ADBannerViewDelegate {
    
    @IBOutlet weak var yourScoreLabel: UILabel!
    @IBOutlet weak var perfectFillsLabel: UILabel!
    @IBOutlet weak var hiScoreLabel: UILabel!
    @IBOutlet weak var congratsLabel: UILabel!
    
    @IBOutlet weak var leaderboardButton: UIButton!
    @IBOutlet weak var playAgainButton: UIButton!
    @IBOutlet weak var menuButton: UIButton!
    
    @IBOutlet weak var adBannerView: ADBannerView!
    
    var current = 0
    var perfect = 0
    var hi = 0
    var concurrent = 0
    
    override func viewDidLoad() {
        
        //super.viewDidLoad()
        
        //set background color
        self.view.backgroundColor = MENU_BACKGROUND_COLOR
        
        //interstitial ad support
        self.interstitialPresentationPolicy = ADInterstitialPresentationPolicy.Automatic
        
        //banner ad support
        self.canDisplayBannerAds = false
        self.adBannerView.layer.zPosition = 5
        self.adBannerView.delegate = self
        self.adBannerView.hidden = true
        
        //set label values
        let defaults = NSUserDefaults.standardUserDefaults()
        
        if let currentScore = defaults.stringForKey(CURRENT_SCORE_KEY) {
            yourScoreLabel.text = currentScore
            current = currentScore.toInt()!
        }
        
        if let perfectScore = defaults.stringForKey(PERFECT_FILLS_KEY) {
            perfectFillsLabel.text = perfectScore
            perfect = perfectScore.toInt()!
        }
        
        if let hiScore = defaults.stringForKey(HI_SCORE_KEY) {
            hiScoreLabel.text = hiScore
            hi = hiScore.toInt()!
        }
        
        if let concurrentScore = defaults.stringForKey(CONCURRENT_PERFECT_FILLS_KEY) {
            concurrent = concurrentScore.toInt()!
        }
        
        //save hi score to leaderboard
        saveHighscore(hi)
        
        //check for circles filled achievement
        checkCirclesFilledAchievements(current)
        
        //check for perfect fills achievement
        checkPerfectFilledAchievements(perfect)
        
        //check for perfect fills in a row achievement
        checkPerfectInRowAchievements(concurrent)
        
        //customize labels
        if (current == hi) {
            congratsLabel.text = ("Nice.")
        }
        else if (hi - current == 1) {
            congratsLabel.text = ("...that's unfortunate.")
        }
        else if (hi - current >= 2 && hi - current < 5) {
            congratsLabel.text = ("Very close!")
        }
        else if (hi - current >= 5 && hi - current < 10) {
            congratsLabel.text = ("I've seen worse.")
        }
        else {
            congratsLabel.text = ("Were you trying?")
        }
        
        //customize buttons
        playAgainButton.addTarget(self, action: "restartGame", forControlEvents: UIControlEvents.TouchUpInside)
        menuButton.addTarget(self, action: "showMenu", forControlEvents: UIControlEvents.TouchUpInside)
        leaderboardButton.addTarget(self, action: "showLeader", forControlEvents: UIControlEvents.TouchUpInside)
        
    }
    
    func restartGame() {
        println("Reloading game...")
        self.canDisplayBannerAds = false
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func showMenu() {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    //save hi score to leaderboard
    func saveHighscore(hi:Int) {
        
        //check if user is signed in
        if GKLocalPlayer.localPlayer().authenticated {
            
            var scoreReporter = GKScore(leaderboardIdentifier: "circleStuffLeaderboard") //leaderboard id here
            
            scoreReporter.value = Int64(hi) //score variable here (same as above)
            
            var scoreArray: [GKScore] = [scoreReporter]
            
            GKScore.reportScores(scoreArray, withCompletionHandler: {(error : NSError!) -> Void in
                if error != nil {
                    println("error")
                }
            })
        }
    }
    
    func checkCirclesFilledAchievements(score:Int) {
        
        if GKLocalPlayer.localPlayer().authenticated {
            
            var twentyFiveCircles = GKAchievement(identifier: "twentyFiveCircles")
            var fiftyCircles = GKAchievement(identifier: "fiftyCircles")
            var oneHundredCircles = GKAchievement(identifier: "oneHundredCircles")
            
            if score >= 25 && score < 50 {
                twentyFiveCircles.percentComplete = 100
                twentyFiveCircles.showsCompletionBanner = true
            }
            else if score >= 50 && score < 100 {
                twentyFiveCircles.percentComplete = 100
                fiftyCircles.percentComplete = 100
                fiftyCircles.showsCompletionBanner = true
            }
            else if score >= 100 {
                twentyFiveCircles.percentComplete = 100
                fiftyCircles.percentComplete = 100
                oneHundredCircles.percentComplete = 100
                oneHundredCircles.showsCompletionBanner = true
            }
            
            var achievements: [GKAchievement] = [twentyFiveCircles, fiftyCircles, oneHundredCircles]
            
            GKAchievement.reportAchievements(achievements, withCompletionHandler:  {(var error:NSError!) -> Void in
                if error != nil {
                    println("Couldn't save achievement progress.")
                }
            })
        }
    }
    
    func checkPerfectFilledAchievements(perfect:Int) {
        
        if GKLocalPlayer.localPlayer().authenticated {
            
            var fivePerfectCircles = GKAchievement(identifier: "fivePerfectCircles")
            var fifteenPerfectCircles = GKAchievement(identifier: "fifteenPerfectCircles")
            var thirtyPerfectCircles = GKAchievement(identifier: "thirtyPerfectCircles")
            
            if perfect >= 5 && perfect < 15 {
                fivePerfectCircles.percentComplete = 100
                fivePerfectCircles.showsCompletionBanner = true
            }
            else if perfect >= 15 && perfect < 30 {
                fivePerfectCircles.percentComplete = 100
                fifteenPerfectCircles.percentComplete = 100
                fifteenPerfectCircles.showsCompletionBanner = true
            }
            else if perfect >= 30 {
                fivePerfectCircles.percentComplete = 100
                fifteenPerfectCircles.percentComplete = 100
                thirtyPerfectCircles.percentComplete = 100
                thirtyPerfectCircles.showsCompletionBanner = true
            }
            
            var achievements: [GKAchievement] = [fivePerfectCircles, fifteenPerfectCircles, thirtyPerfectCircles]
            
            GKAchievement.reportAchievements(achievements, withCompletionHandler:  {(var error:NSError!) -> Void in
                if error != nil {
                    println("Couldn't save achievement progress.")
                }
            })
        }
    }
    
    func checkPerfectInRowAchievements(perfect:Int) {
        if GKLocalPlayer.localPlayer().authenticated {
            
            var fiveInARow = GKAchievement(identifier: "fiveInARow")
            
            if perfect >= 5 {
                fiveInARow.percentComplete = 100
                fiveInARow.showsCompletionBanner = true
            }
            
            GKAchievement.reportAchievements([fiveInARow], withCompletionHandler:  {(var error:NSError!) -> Void in
                if error != nil {
                    println("Couldn't save achievement progress.")
                }
            })
        }
    }
    
    //show leaderboard
    func showLeader() {
        var vc = self
        var gc = GKGameCenterViewController()
        gc.gameCenterDelegate = self
        vc.presentViewController(gc, animated: true, completion: nil)
    }
    
    //hide leaderboard
    func gameCenterViewControllerDidFinish(gameCenterViewController: GKGameCenterViewController!) {
        gameCenterViewController.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //banner ad delegate methods
    func bannerViewDidLoadAd(banner: ADBannerView!) {
        println("Loaded ad.")
        self.adBannerView.hidden = false
    }
    
    func bannerViewActionShouldBegin(banner: ADBannerView!, willLeaveApplication willLeave: Bool) -> Bool {
        return true
    }
    
    func bannerViewActionDidFinish(banner: ADBannerView!) {
        
    }
    
    func bannerView(banner: ADBannerView!, didFailToReceiveAdWithError error: NSError!) {
        println("Failed to load ad")
        self.adBannerView.hidden = true
    }
}
