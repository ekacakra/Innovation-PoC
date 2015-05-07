//
//  CoinDetailInterfaceController.swift
//  Innovation PoC WatchKit Extension
//
//  Created by Ibnu Siena on 5/6/15.
//  Copyright (c) 2015 Photon Interactive. All rights reserved.
//

import Foundation
import WatchKit
import CoinKit

class CoinDetailInterfaceController:WKInterfaceController {
    @IBOutlet weak var coinImage: WKInterfaceImage!
    @IBOutlet weak var nameLabel: WKInterfaceLabel!
    @IBOutlet weak var table: WKInterfaceTable!
    @IBOutlet weak var favoriteSwitch: WKInterfaceSwitch!
    
    var coin: Coin!
    let defaults = NSUserDefaults.standardUserDefaults()
    let favoriteCoinKey = "favoriteCoin"
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        if let coin = context as? Coin {
            self.coin = coin
            setTitle(coin.name)
            coinImage.setImageNamed(coin.name)
            nameLabel.setText(coin.name)
            
            // First create two arrays: the first holds the titles of each row, and the second the values.
            let titles = ["Current Price", "Yesterday's Price", "Volume", "Best Market", "Latest Trade"]
            let values = ["\(coin.price) USD", "\(coin.price24h) USD", String(format: "%.4f", coin.volume), coin.bestMarket, coin.latestTrade]
            
            // Set the number of rows on the table; in this case you use the count of the titles array. You also inform the table that it should be using the CoinRow row type, which matches the identifier you set in the storyboard.
            table.setNumberOfRows(titles.count, withRowType: "CoinRow")
            
            // Iterate over each row in the table and set its titleLabel and detailLabel to the corresponding values in the titles and values arrays. You also make use of downcasting to ensure you’re dealing with an instance of CoinRow.
            for i in 0..<values.count {
                if let row = table.rowControllerAtIndex(i) as? CoinRow {
                    row.titleLable.setText(titles[i])
                    row.detailLable.setText(values[i])
                    
                    if let favoriteCoin = defaults.stringForKey(favoriteCoinKey) {
                        favoriteSwitch.setOn(favoriteCoin == coin.name)
                    }
                }
            }
        }
    }
    
    @IBAction func favoriteSwitchValueChanged(value: Bool) {
        // First, since the coin property is an optional, you unwrap it to make sure it’s not nil before continuing.
        if let coin = coin {
            // Next, you remove any previously stored favorite from the defaults.
            defaults.removeObjectForKey(favoriteCoinKey)
            
            // Then, if value is true it means the user has set the switch to on, so you store the name of the current coin as the favorite in the defaults.
            if value {
                defaults.setObject(coin.name, forKey: favoriteCoinKey)
            }
            
            // Finally, you synchronize the defaults to guarantee the changes are written to disk and any observers are notified of the changes.
            defaults.synchronize()
        }
    }
}