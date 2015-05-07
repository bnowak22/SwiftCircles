//
//  InstructionsViewController.swift
//  SwiftCircles
//
//  Created by bnowak on 5/6/15.
//  Copyright (c) 2015 DoomDuck Studios. All rights reserved.
//

import Foundation
import UIKit

class InstructionsViewController: UIViewController {

    @IBOutlet weak var circleImageView: UIImageView!
    
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var menuButton: UIButton!
    
    override func viewDidLoad() {
        
        //set background color
        self.view.backgroundColor = MENU_BACKGROUND_COLOR
        
        //set images
        circleImageView.image = UIImage(named: "circle_screenshot.png")
        
        circleImageView.autoresizingMask = UIViewAutoresizing.FlexibleBottomMargin | UIViewAutoresizing.FlexibleHeight | UIViewAutoresizing.FlexibleRightMargin | UIViewAutoresizing.FlexibleLeftMargin | UIViewAutoresizing.FlexibleTopMargin | UIViewAutoresizing.FlexibleWidth
        circleImageView.contentMode = UIViewContentMode.ScaleAspectFit
        
        //set buttons
        nextButton.addTarget(self, action: "nextInstruction", forControlEvents: UIControlEvents.TouchUpInside)
        menuButton.addTarget(self, action: "showMenu", forControlEvents: UIControlEvents.TouchUpInside)
        
    }
    
    func showMenu() {
        self.performSegueWithIdentifier("showMenuSegue", sender: nil)
    }
    
    func nextInstruction() {
        self.performSegueWithIdentifier("showNextInstructionSegue", sender: nil)
    }
    
}