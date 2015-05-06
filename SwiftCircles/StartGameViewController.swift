//
//  StartGameViewController.swift
//  SwiftCircles
//
//  Created by bnowak on 5/6/15.
//  Copyright (c) 2015 DoomDuck Studios. All rights reserved.
//

import Foundation
import UIKit

class StartGameViewController: UIViewController {

    @IBOutlet weak var instructionsButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    
    override func viewDidLoad() {
        
        //set background color
        self.view.backgroundColor = BACKGROUND_COLOR
        
        //customize labels
        
        //customize buttons
        playButton.addTarget(self, action: "startGame", forControlEvents: UIControlEvents.TouchUpInside)
        
    }
    
    func startGame() {
        self.performSegueWithIdentifier("startGameSegue", sender: nil)
    }
    
}