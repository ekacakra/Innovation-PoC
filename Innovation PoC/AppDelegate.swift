//
//  AppDelegate.swift
//  Innovation PoC
//
//  Created by C1MNC7DMDTY3 on 5/6/15.
//  Copyright (c) 2015 Photon Interactive. All rights reserved.
//

import UIKit
import CoinKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func application(application: UIApplication, handleWatchKitExtensionRequest userInfo: [NSObject : AnyObject]?, reply: (([NSObject : AnyObject]!) -> Void)!) {
        // Check for the request key and its value, just to be sure it’s really the watch app calling.
        if let userInfo = userInfo, request = userInfo["request"] as? String {
            if request == "refreshData" {
                // Instantiate CoinHelper to perform the network request. Note that you’re calling the synchronous version of the fetch request; if you performed a background fetch instead, the method would return right away and the reply would always be empty, which would be of no use to you.
                let coinHelper = CoinHelper()
                let coins = coinHelper.requestPriceSynchronous()
                
                // After the request comes back, you call the reply handler. coins is an array of Coin objects, so you need to archive the array into an NSData instance so it survives the trip back to WatchKit.
                reply(["coinData": NSKeyedArchiver.archivedDataWithRootObject(coins)])
                
                return
            } else if request == "map" {
                var tmpDelegate : AppDelegate = (UIApplication.sharedApplication().delegate as? AppDelegate)!
                var vc : ViewController = ((tmpDelegate.window!.rootViewController as? UINavigationController)?.visibleViewController as? ViewController)!
                var replyObject = vc.getCurrentLocation()
                reply(replyObject)
                return
            }
        }
        
        // If something goes wrong, the default action is to send back an empty dictionary.
        reply([:])
    }
    
}