//
//  CoinGlanceInterfaceController.swift
//  Innovation PoC WatchKit Extension
//
//  Created by Ibnu Siena on 5/6/15.
//  Copyright (c) 2015 Photon Interactive. All rights reserved.
//

import Foundation
import WatchKit
import CoinKit

class CoinGlanceInterfaceController:WKInterfaceController {
    // You define three outlets for the coin icon, name, and current price.
    @IBOutlet weak var coinImage: WKInterfaceImage!
    @IBOutlet weak var nameLabel: WKInterfaceLabel!
    @IBOutlet weak var priceLabel:WKInterfaceLabel!
    
    // Create a reference to the CoinHelper class so you can access the cached coin data, and a reference to the standard user defaults so you can retrieve the user’s favorite cryptocurrency.
    let helper = CoinHelper()
    let defaults = NSUserDefaults.standardUserDefaults()
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Ask the defaults for the user’s favorite currency. It’s possible the user hasn’t selected a favorite and the defaults will return nil. To cover this case, you use the nil coalescing operator to select Bitcoin by default.
        
        let favoriteCoin = defaults.stringForKey("favoriteCoin") ?? "BTC"
        
        // Retrieve the cached coin data using the CoinHelper class and iterate over each of the cached coins.
        let coins = helper.cachedPrices()
        
        for coin in coins {
            // If the name of the current cached coin matches the favorite, you use its data to populate the glance, via the outlets. You also break out of the loop early since you’ve found a match.
            if coin.name == favoriteCoin {
                coinImage.setImageNamed(coin.name)
                nameLabel.setText(coin.name)
                priceLabel.setText("\(coin.price)")
                updateUserActivity("com.simple.apple.watch.glance", userInfo: ["coin": coin.name], webpageURL: nil)
                break
            }
        }
    }
    
}
