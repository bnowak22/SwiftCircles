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
    
    @IBOutlet weak var playAgainButton: UIButton!
    @IBOutlet weak var menuButon: UIButton!
    
    override func viewDidLoad() {
        
        //set background color
        self.view.backgroundColor = BACKGROUND_COLOR
        
        //customize labels
        
        //set label values
        let defaults = NSUserDefaults.standardUserDefaults()
        
        if let currentScore = defaults.stringForKey(CURRENT_SCORE_KEY) {
            yourScoreValue.text = String(currentScore)
        }
        
        if let hiScore = defaults.stringForKey(HI_SCORE_KEY) {
            hiScoreValue.text = String(hiScore)
        }
        
        //customize buttons
        playAgainButton.addTarget(self, action: "restartGame", forControlEvents: UIControlEvents.TouchUpInside)
        
    }
    
    func restartGame() {
        println("Reloading game...")
        self.performSegueWithIdentifier("restartGameSegue", sender: nil)
    }
    
}
