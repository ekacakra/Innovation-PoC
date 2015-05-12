//
//  ViewQRCodeController.swift
//  Innovation PoC
//
//  Created by Ibnu Siena on 5/12/15.
//  Copyright (c) 2015 Photon Interactive. All rights reserved.
//

import WatchKit

class ViewQRCodeController: WKInterfaceController {
    @IBOutlet weak var qrImageView: WKInterfaceImage!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        if let qrData = context as? String {
            WKInterfaceController.openParentApplication(["request": ["generateQRCode":qrData]], reply: {(replyInfo, error) -> Void in
                if replyInfo != nil {
                    if let qrData = replyInfo["qrData"] as? NSData {
                        self.qrImageView.setImageData(qrData)
                    } else {
                        self.qrImageView.setImageNamed("no_data")
                    }
                } else {
                    self.qrImageView.setImageNamed("no_data")
                }
            })
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
