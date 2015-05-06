//
//  EndGameViewController.swift
//  SwiftCircles
//
//  Created by bnowak on 5/5/15.
//  Copyright (c) 2015 DoomDuck Studios. All rights reserved.
//

import Foundation
import UIKit

class EndGameViewController: UIViewController {
    
    @IBOutlet weak var yourScoreLabel: UILabel!
    @IBOutlet weak var yourScoreValue: UILabel!

    @IBOutlet weak var hiScoreLabel: UILabel!
    @IBOutlet weak var hiScoreValue: UILabel!
    
    @IBOutlet weak var congratsLabel: UILabel!
    
    @IBOutlet weak var playAgainButton: UIButton!
    @IBOutlet weak var menuButton: UIButton!
    
    var current = 0
    var hi = 0
    
    override func viewDidLoad() {
        
        //set background color
        self.view.backgroundColor = BACKGROUND_COLOR
        
        //set label values
        let defaults = NSUserDefaults.standardUserDefaults()
        
        if let currentScore = defaults.stringForKey(CURRENT_SCORE_KEY) {
            yourScoreValue.text = currentScore + "."
            current = currentScore.toInt()!
        }
        
        if let hiScore = defaults.stringForKey(HI_SCORE_KEY) {
            hiScoreValue.text = hiScore + "."
            hi = hiScore.toInt()!
        }
        
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
        
    }
    
    func restartGame() {
        println("Reloading game...")
        self.performSegueWithIdentifier("restartGameSegue", sender: nil)
    }
    
    func showMenu() {
        self.performSegueWithIdentifier("showMenuSegue", sender: nil)
    }
    
}
