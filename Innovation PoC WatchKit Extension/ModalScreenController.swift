//
//  ScreenModalController.swift
//  Innovation PoC
//
//  Created by Ibnu Siena on 5/7/15.
//  Copyright (c) 2015 Photon Interactive. All rights reserved.
//

import Foundation
import WatchKit

class ModalScreenController: WKInterfaceController {
    @IBOutlet weak var image: WKInterfaceImage!
    @IBOutlet weak var label: WKInterfaceLabel!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
        if let contextDict = context as? NSDictionary {
            let type = contextDict["type"] as! String
            let value = contextDict["value"] as! String
            if type == "image" {
                label.setHidden(true)
                image.setHidden(false)
                image.setImageNamed(value)
            } else {
                label.setHidden(false)
                image.setHidden(true)
                label.setText("Page \(value)")
            }
            
        }
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
}