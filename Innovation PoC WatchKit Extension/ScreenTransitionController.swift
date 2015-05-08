//
//  ScreenTransitionController.swift
//  Innovation PoC
//
//  Created by Ibnu Siena on 5/8/15.
//  Copyright (c) 2015 Photon Interactive. All rights reserved.
//

import Foundation
import WatchKit

class ScreenTransitionController: WKInterfaceController {
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    @IBAction func modalButtonAction() {
        var controllerName = [String]()
        
        for i in 0..<5 {
            controllerName.append("ModalScreenController")
        }
        
        let context: [[String:String]] = [["type":"image", "value":"appleWatchKit-1"], ["type":"image", "value":"appleWatchKit-2"], ["type":"label", "value":"Third"], ["type":"image", "value":"BTC"], ["type":"label", "value":"Fifth"]]
        
        presentControllerWithNames(controllerName, contexts: context)
    }
   
}