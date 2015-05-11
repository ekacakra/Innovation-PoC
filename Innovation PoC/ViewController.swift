//
//  ViewController.swift
//  Innovation PoC
//
//  Created by C1MNC7DMDTY3 on 5/6/15.
//  Copyright (c) 2015 Photon Interactive. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var locationTable: UITableView!
    @IBOutlet weak var latitudeTextField: UITextField!
    @IBOutlet weak var longitudeTextField: UITextField!
    @IBOutlet weak var currentLatitude: UILabel!
    @IBOutlet weak var currentLongitude: UILabel!
    var locationData: [[String:String]] = []
    var currentLocationLatitude: Double = 0.0
    var currentLocationLongitude: Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let userDefaults = NSUserDefaults.standardUserDefaults()
        if (userDefaults.arrayForKey("location") != nil) {
            locationData = (userDefaults.arrayForKey("location") as? [[String:String]])!
        }
        currentLatitude.text = String(format:"%f", currentLocationLatitude)
        currentLongitude.text = String(format:"%f", currentLocationLongitude)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locationData.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:LocationTableCell = self.locationTable.dequeueReusableCellWithIdentifier("cell") as! LocationTableCell
        
        cell.latitude?.text = self.locationData[indexPath.row]["latitude"]
        cell.longitude?.text = self.locationData[indexPath.row]["longitude"]
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        var latitude: String = self.locationData[indexPath.row]["latitude"]!
        var longitude: String = self.locationData[indexPath.row]["longitude"]!
        currentLocationLatitude = (latitude as NSString).doubleValue
        currentLocationLongitude = (longitude as NSString).doubleValue
        currentLatitude.text = latitude
        currentLongitude.text = longitude
    }
    @IBAction func applyLocation(sender: AnyObject) {
        var latitude: String = latitudeTextField.text!
        var longitude: String = longitudeTextField.text!
        currentLocationLatitude = (latitude as NSString).doubleValue
        currentLocationLongitude = (longitude as NSString).doubleValue
        currentLatitude.text = latitude
        currentLongitude.text = longitude
    }
    
    @IBAction func saveLocation(sender: AnyObject) {
        var latitude: String = latitudeTextField.text!
        var longitude: String = longitudeTextField.text!
        var locationObject: [String:String] = ["latitude":latitude, "longitude":longitude]
        locationData.append(locationObject)
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setObject(locationData, forKey: "location")
        locationTable.reloadData()
    }
    
    func getCurrentLocation() -> [String:String]{
        var latitude = String(format:"%f", currentLocationLatitude)
        var longitude = String(format:"%f", currentLocationLongitude)
        if latitude == "0.000000" {
            latitude = "-6.226956"
        }
        if longitude == "0.000000" {
            longitude = "106.833458"
        }
        
        var currentLocationObject: [String:String] = ["latitude":latitude, "longitude":longitude]
        return currentLocationObject
    }

}

