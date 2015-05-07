//
//  MapController.swift
//  Innovation PoC
//
//  Created by C1MNC7DMDTY3 on 5/6/15.
//  Copyright (c) 2015 Photon Interactive. All rights reserved.
//

import Foundation
import WatchKit

class MapController : WKInterfaceController {
    @IBOutlet weak var map: WKInterfaceMap!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        setupMap()
    }
    
    func setupMap() {
        let location = CLLocationCoordinate2D(
            latitude: 51.505248,
            longitude: -0.113838)
        
        let region = MKCoordinateRegion(center: location, span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))
        self.map.setRegion(region)
    }
}
