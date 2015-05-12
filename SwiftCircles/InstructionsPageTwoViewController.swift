//
//  InstructionsPageTwoViewController.swift
//  SwiftCircles
//
//  Created by bnowak on 5/7/15.
//  Copyright (c) 2015 DoomDuck Studios. All rights reserved.
//

import Foundation
import UIKit

class InstructionsPageTwoViewController: UIViewController {
    
    @IBOutlet weak var scoringImageView: UIImageView!
    
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var menuButton: UIButton!
    
    override func viewDidLoad() {
        
        //set background color
        self.view.backgroundColor = MENU_BACKGROUND_COLOR
        
        //set images
        scoringImageView.image = UIImage(named: "scoring_screenshot.png")
        
        scoringImageView.autoresizingMask = UIViewAutoresizing.FlexibleBottomMargin | UIViewAutoresizing.FlexibleHeight | UIViewAutoresizing.FlexibleRightMargin | UIViewAutoresizing.FlexibleLeftMargin | UIViewAutoresizing.FlexibleTopMargin | UIViewAutoresizing.FlexibleWidth
        scoringImageView.contentMode = UIViewContentMode.ScaleAspectFit
        
        //set buttons
        playButton.addTarget(self, action: "playGame", forControlEvents: UIControlEvents.TouchUpInside)
        menuButton.addTarget(self, action: "showMenu", forControlEvents: UIControlEvents.TouchUpInside)
        
    }
    
    func showMenu() {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    func playGame() {
        self.performSegueWithIdentifier("playGameSegue", sender: nil)
    }
    
}