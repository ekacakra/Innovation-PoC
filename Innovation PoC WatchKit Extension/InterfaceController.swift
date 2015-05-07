//
//  InterfaceController.swift
//  Innovation PoC WatchKit Extension
//
//  Created by C1MNC7DMDTY3 on 5/6/15.
//  Copyright (c) 2015 Photon Interactive. All rights reserved.
//

import WatchKit
import Foundation
import CoinKit


class InterfaceController: WKInterfaceController {
    let coinHelper = CoinHelper()

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
    
    // handleUserActivity(_:) is called only on the initial interface controller — as denoted by the Main arrow in the storyboard shown below — which is why you’ve overridden it in CoinsInterfaceController:
    override func handleUserActivity(userInfo: [NSObject : AnyObject]!) {
        // First check to see if the coin key and value pair exist in the userInfo dictionary. You also try to downcast the value to a String as that’s what you originally passed from the glance.
        if let handedCoin = userInfo["coin"] as? String {
            // If the key and value pair exist, you retrieve all the cached coins using the CoinHelper class.
            let coins = coinHelper.cachedPrices()
            
            // Enumerate over the cached coin data, looking for a match against the string that came in from the userInfo dictionary.
            for coin in coins {
                if coin.name == handedCoin {
                    // If there’s a match, you push the coin detail interface controller onto the navigation stack, passing the current coin as the context object.
                    pushControllerWithName("CoinDetailInterfaceController", context: coin)
                    break
                }
            }
            
        }
    }
    
}
