/*
* Copyright (c) 2015 Razeware LLC
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
* THE SOFTWARE.
*/

import WatchKit
import Foundation
import CoinKit

class CoinsInterfaceController: WKInterfaceController {
    @IBOutlet weak var coinTable: WKInterfaceTable!
    
    var coins = [Coin]()
    let coinHelper = CoinHelper()
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        coins = coinHelper.cachedPrices()
        
        //openParentApplication(_:reply:) is a class method on WKInterfaceController that forces the iOS app — that is, the parent application — to launch.
        WKInterfaceController.openParentApplication(["request": "refreshData"],
            reply: { (replyInfo, error) -> Void in
                // TODO: process reply data
                if let coinData = replyInfo["coinData"] as? NSData {
                    if let coins =  NSKeyedUnarchiver.unarchiveObjectWithData(coinData) as? [Coin] {
                        self.coinHelper.cachePriceData(coins)
                        self.coins = coins
                        self.reloadTable()
                    }
                }
        
        })
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        reloadTable()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    func reloadTable() {
        //Set the number of rows and their type; the type string here is the identifier you set on the table row back in the storyboard. Since you don’t have any coin data yet, you’re hard-coding ten rows just to test things out.
        if coinTable.numberOfRows != coins.count {
            coinTable.setNumberOfRows(coins.count, withRowType: "CoinRow")
        }
        
        for (index, coin) in enumerate(coins) {
            //Once you have coin data, you enumerate through the array of coins. At this point the table has already created the ten row objects, so rowControllerAtIndex(_:) simply fetches the object for a particular row. To be safe, there’s some optional binding here to ensure your code is dealing with CoinRow objects.
            if let row = coinTable.rowControllerAtIndex(index) as? CoinRow {
                //Finally, if the creation of your CoinRow succeeded, you set the text for the two labels.
                row.titleLable.setText(coin.name)
                row.detailLable.setText("\(coin.price) USD")
            }
        }
        
    }
    
    override func contextForSegueWithIdentifier(segueIdentifier: String, inTable table:WKInterfaceTable, rowIndex: Int) -> AnyObject? {
        if segueIdentifier == "CoinDetails" {
            let coin = coins[rowIndex]
            return coin
        }
        
        return nil
    }
}
