//
//  NotificationController.swift
//  Innovation PoC WatchKit Extension
//
//  Created by C1MNC7DMDTY3 on 5/6/15.
//  Copyright (c) 2015 Photon Interactive. All rights reserved.
//

import WatchKit
import Foundation


class NotificationController: WKUserNotificationInterfaceController {

    @IBOutlet weak var dateText: WKInterfaceLabel!
    @IBOutlet weak var dayText: WKInterfaceLabel!
    @IBOutlet weak var timeText: WKInterfaceLabel!
    @IBOutlet weak var placeText: WKInterfaceLabel!
    @IBOutlet weak var message: WKInterfaceLabel!
    override init() {
        // Initialize variables here.
        super.init()
        
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

    /*
    override func didReceiveLocalNotification(localNotification: UILocalNotification, withCompletion completionHandler: ((WKUserNotificationInterfaceType) -> Void)) {
        // This method is called when a local notification needs to be presented.
        // Implement it if you use a dynamic notification interface.
        // Populate your dynamic notification interface as quickly as possible.
        //
        // After populating your dynamic notification interface call the completion block.
        completionHandler(.Custom)
    }
    */
    
    
    override func didReceiveRemoteNotification(remoteNotification: [NSObject : AnyObject], withCompletion completionHandler: ((WKUserNotificationInterfaceType) -> Void)) {
        // This method is called when a remote notification needs to be presented.
        // Implement it if you use a dynamic notification interface.
        // Populate your dynamic notification interface as quickly as possible.
        //
        // After populating your dynamic notification interface call the completion block.
        
        if remoteNotification.isEmpty == false {
            if let aps = (remoteNotification["aps"] as? NSDictionary) {
                dateText.setText(aps["date"] as? String)
                dayText.setText(aps["day"] as? String)
                timeText.setText(aps["time"] as? String)
                placeText.setText(aps["place"] as? String)
                message.setText(aps["note"] as? String)
            }
        }
        
        completionHandler(.Custom)
    }
    
}
