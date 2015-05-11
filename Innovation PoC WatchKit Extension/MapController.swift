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
    var region: MKCoordinateRegion!
    var currentLocation: CLLocationCoordinate2D!
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        WKInterfaceController.openParentApplication(["request":"map"]) { (replyInfo, error) -> Void in
            var latitudeReply: Double = (replyInfo["latitude"] as! NSString).doubleValue
            var longitudeReply: Double = (replyInfo["longitude"] as! NSString).doubleValue
            let location = CLLocationCoordinate2D(
                latitude: latitudeReply,
                longitude: longitudeReply)
            println(latitudeReply)
            println(longitudeReply)
            self.currentLocation = location
            self.setupMap(location)
        }
        
    }
    
    func setupMap(location: CLLocationCoordinate2D) {
        self.region = MKCoordinateRegion(center: location, span: self.currentSpan)
        var newCenterPoint = MKMapPointForCoordinate(location);
        
        var mapRect = MKMapRectMake(newCenterPoint.x, newCenterPoint.y, self.currentSpan.latitudeDelta, self.currentSpan.longitudeDelta)
        
        self.map.addAnnotation(location, withPinColor: WKInterfaceMapPinColor.Green)
        self.map.setVisibleMapRect(mapRect)
        self.map.setRegion(region)
    }
    
    @IBAction func zoomIn() {
        var span: MKCoordinateSpan = MKCoordinateSpanMake(self.currentSpan.latitudeDelta * 0.5, self.currentSpan.longitudeDelta * 0.5);
        var region: MKCoordinateRegion = MKCoordinateRegionMake(self.region.center, span);
        
        self.currentSpan = span;
        self.map.setRegion(region);
    }
    
    @IBAction func zoomOut() {
        var span: MKCoordinateSpan = MKCoordinateSpanMake(self.currentSpan.latitudeDelta * 2, self.currentSpan.longitudeDelta * 2);
        var region: MKCoordinateRegion = MKCoordinateRegionMake(self.region.center, span);
        
        self.currentSpan = span;
        self.map.setRegion(region);
    }
    
    @IBAction func showPin(value: Bool) {
        if value {
            self.map.addAnnotation(currentLocation, withPinColor: WKInterfaceMapPinColor.Green)
        } else {
            self.map.removeAllAnnotations()
        }
    }
}
