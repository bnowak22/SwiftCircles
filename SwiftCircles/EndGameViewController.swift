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

class EndGameViewController: UIViewController, GKGameCenterControllerDelegate {
    
    @IBOutlet weak var yourScoreLabel: UILabel!
    @IBOutlet weak var perfectFillsLabel: UILabel!
    @IBOutlet weak var hiScoreLabel: UILabel!
    @IBOutlet weak var congratsLabel: UILabel!
    
    @IBOutlet weak var leaderboardButton: UIButton!
    @IBOutlet weak var playAgainButton: UIButton!
    @IBOutlet weak var menuButton: UIButton!
    
    var current = 0
    var perfect = 0
    var hi = 0
    
    override func viewDidLoad() {
        
        //set background color
        self.view.backgroundColor = MENU_BACKGROUND_COLOR
        
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
        
        //save hi score to leaderboard
        saveHighscore(hi)
        
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
        self.performSegueWithIdentifier("restartGameSegue", sender: nil)
    }
    
    func showMenu() {
        self.performSegueWithIdentifier("showMenuSegue", sender: nil)
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
}
