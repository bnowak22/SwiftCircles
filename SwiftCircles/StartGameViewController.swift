//
//  StartGameViewController.swift
//  SwiftCircles
//
//  Created by bnowak on 5/6/15.
//  Copyright (c) 2015 DoomDuck Studios. All rights reserved.
//

import Foundation
import UIKit
import GameKit

class StartGameViewController: UIViewController {

    @IBOutlet weak var instructionsButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    
    @IBOutlet weak var circleImageView: UIImageView!
    
    override func viewDidLoad() {
        
        //authenticate
        authenticateLocalPlayer()
        
        //set background color
        self.view.backgroundColor = MENU_BACKGROUND_COLOR
        
        //customize labels
        
        //set image
        circleImageView.image = UIImage(named: "filling_circle_screenshot.png")
        circleImageView.autoresizingMask = UIViewAutoresizing.FlexibleBottomMargin | UIViewAutoresizing.FlexibleHeight | UIViewAutoresizing.FlexibleRightMargin | UIViewAutoresizing.FlexibleLeftMargin | UIViewAutoresizing.FlexibleTopMargin | UIViewAutoresizing.FlexibleWidth
        circleImageView.contentMode = UIViewContentMode.ScaleAspectFit
        
        //customize buttons
        playButton.addTarget(self, action: "startGame", forControlEvents: UIControlEvents.TouchUpInside)
        instructionsButton.addTarget(self, action: "showInstructions", forControlEvents: UIControlEvents.TouchUpInside)
        
    }
    
    func startGame() {
        self.performSegueWithIdentifier("startGameSegue", sender: nil)
    }
    
    func showInstructions() {
        self.performSegueWithIdentifier("showInstructionsSegue", sender: nil)
    }
    
    //game center auth
    func authenticateLocalPlayer(){
        
        var localPlayer = GKLocalPlayer.localPlayer()
        
        localPlayer.authenticateHandler = {(viewController, error) -> Void in
            
            if (viewController != nil) {
                self.presentViewController(viewController, animated: true, completion: nil)
            }
                
            else {
                println((GKLocalPlayer.localPlayer().authenticated))
            }
        }
        
    }
    
}