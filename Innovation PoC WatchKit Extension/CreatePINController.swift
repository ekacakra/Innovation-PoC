//
//  CreatePINController.swift
//  Innovation PoC
//
//  Created by Ibnu Siena on 5/12/15.
//  Copyright (c) 2015 Photon Interactive. All rights reserved.
//

import Foundation
import WatchKit

class CreatePINController: WKInterfaceController {
    @IBOutlet weak var button0: WKInterfaceButton!
    @IBOutlet weak var button1: WKInterfaceButton!
    @IBOutlet weak var button2: WKInterfaceButton!
    @IBOutlet weak var button3: WKInterfaceButton!
    @IBOutlet weak var button4: WKInterfaceButton!
    @IBOutlet weak var button5: WKInterfaceButton!
    @IBOutlet weak var button6: WKInterfaceButton!
    @IBOutlet weak var button7: WKInterfaceButton!
    @IBOutlet weak var button8: WKInterfaceButton!
    @IBOutlet weak var button9: WKInterfaceButton!
    
    let BUTTON0: String = "button0"
    let BUTTON1: String = "button1"
    let BUTTON2: String = "button2"
    let BUTTON3: String = "button3"
    let BUTTON4: String = "button4"
    let BUTTON5: String = "button5"
    let BUTTON6: String = "button6"
    let BUTTON7: String = "button7"
    let BUTTON8: String = "button8"
    let BUTTON9: String = "button9"
    
    
    var resultValue: String = ""
    var tempRandomValue = [String: String]()
    var arrayButton = [WKInterfaceButton]()
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        arrayButton = [button0, button1, button2, button3, button4, button5, button6, button7, button8, button9]
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        self.createRandomButton()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    @IBAction func buttonAction1() {
        self.createResultValue(BUTTON1)
    }
    
    @IBAction func buttonAction2() {
        self.createResultValue(BUTTON2)
    }
    
    @IBAction func buttonAction3() {
        self.createResultValue(BUTTON3)
    }
    
    @IBAction func buttonAction4() {
        self.createResultValue(BUTTON4)
    }
    
    @IBAction func buttonAction5() {
        self.createResultValue(BUTTON5)
    }
    
    @IBAction func buttonAction6() {
        self.createResultValue(BUTTON6)
    }
    
    @IBAction func buttonAction7() {
        self.createResultValue(BUTTON7)
    }
    
    @IBAction func buttonAction8() {
        self.createResultValue(BUTTON8)
    }
    
    @IBAction func buttonAction9() {
        self.createResultValue(BUTTON9)
    }
    
    @IBAction func buttonAction0() {
        self.createResultValue(BUTTON0)
    }
    
    func createRandomButton() {
        var tempValue = [Int]()
        var isLooping = true
        
        while isLooping == true {
            let randomValue = self.randomValue()
            
            if(tempValue.count > 0) {
                var isDuplicateValue = false
                for value in tempValue {
                    if value == randomValue {
                        isDuplicateValue = true
                    }
                }
                
                if isDuplicateValue == false {
                    tempValue.append(randomValue)
                }
            } else {
                tempValue.append(randomValue)
            }
            
            if(tempValue.count == 10) {
                isLooping = false
            }
        }
        
        for (index, value) in enumerate(tempValue) {
            self.setTittleButton(index, randomValue: value)
        }
        
        tempValue.removeAll(keepCapacity: false)
    }
    
    func setTittleButton(index: Int, randomValue: Int) {
        arrayButton[index].setTitle(String(randomValue))
        tempRandomValue.updateValue(String(randomValue), forKey: "button\(index)")
    }
    
    func randomValue() -> Int{
        // arc4random_uniform(10) to generate a random number between 0 and 9.
        return Int(arc4random_uniform(10))
    }
    
    func createResultValue(key: String) {
        let value: String = tempRandomValue[key]!
        
       if count(resultValue) < 4 {
            resultValue += value
            
            if count(resultValue) == 4 {
                self.pushControllerWithName("ViewQRCodeController", context: self.resultValue)
                self.resultValue = ""
            }
        }
    }
}
