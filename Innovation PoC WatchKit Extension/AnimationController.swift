//
//  AnimationController.swift
//  Innovation PoC
//
//  Created by C1MNC7DMDTY3 on 5/7/15.
//  Copyright (c) 2015 Photon Interactive. All rights reserved.
//

import Foundation
import WatchKit

class AnimationController : WKInterfaceController {
    @IBOutlet weak var imageAnimation: WKInterfaceImage!
    @IBOutlet weak var speedLabel: WKInterfaceLabel!
    var speed: Double = 0
    let speedObject = [["label":"0 fps","speed":0],["label":"1 fps","speed":1024],["label":"10 fps","speed":102],["label":"25 fps","speed":40],["label":"30 fps","speed":34],["label":"60 fps","speed":17]]
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        speed = (speedObject[1]["speed"] as? Double)!
        speedLabel.setText((speedObject[1]["label"] as? String)!)
        startAnimating()
    }
    
    func startAnimating() {
        imageAnimation.stopAnimating()
        imageAnimation.setImageNamed("number")
        imageAnimation.startAnimatingWithImagesInRange(
            NSRange(location: 0, length: 1024),
            duration: speed,
            repeatCount: Int.max)
    }
    
    @IBAction func speedChange(value: Float) {
        var index: Int = Int(value)
        var label = speedObject[index]["label"]!
        var speed = speedObject[index]["speed"]!
        self.speedLabel.setText(label as? String)
        self.speed = (speed as? Double)!
    }
    
    @IBAction func applyCustomSpeed() {
        if speed == 0 {
            imageAnimation.stopAnimating()
        } else {
            startAnimating()
        }
    }
    
    @IBAction func stopAnimating() {
        imageAnimation.stopAnimating()
    }
}