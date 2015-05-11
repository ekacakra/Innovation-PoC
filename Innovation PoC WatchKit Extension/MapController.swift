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
    var currentSpan = MKCoordinateSpanMake(1.0, 1.0);
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        WKInterfaceController.openParentApplication(["request":"map"]) { (replyInfo, error) -> Void in
            var latitudeReply: Double = (replyInfo["latitude"] as! NSString).doubleValue
            var longitudeReply: Double = (replyInfo["longitude"] as! NSString).doubleValue
            let location = CLLocationCoordinate2D(
                latitude: latitudeReply,
                longitude: longitudeReply)
            self.setupMap(location)
        }
        
    }
    
    func setupMap(location: CLLocationCoordinate2D) {
        let region = MKCoordinateRegion(center: location, span: self.currentSpan)
        var newCenterPoint = MKMapPointForCoordinate(location);
        
        var mapRect = MKMapRectMake(newCenterPoint.x, newCenterPoint.y, self.currentSpan.latitudeDelta, self.currentSpan.longitudeDelta)
        
        self.map.addAnnotation(location, withPinColor: WKInterfaceMapPinColor.Green)
        self.map.setVisibleMapRect(mapRect)
        self.map.setRegion(region)
    }
}
