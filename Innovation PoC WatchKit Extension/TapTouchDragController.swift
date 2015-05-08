//
//  TapTouchDragController.swift
//  Innovation PoC
//
//  Created by C1MNC7DMDTY3 on 5/6/15.
//  Copyright (c) 2015 Photon Interactive. All rights reserved.
//

import Foundation
import WatchKit

class TapTouchDragController: WKInterfaceController {
    @IBOutlet weak var statusLabel: WKInterfaceLabel!
    
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
    
    @IBAction func tapAction() {
        statusLabel.setText("Tapping!")
    }
    
    @IBAction func menuIconTapped() {
        println("Menu Item Tapped")
    }
}
