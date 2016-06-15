//
//  AppDelegate.swift
//  FixedGear
//
//  Created by Brian Henry on 13/06/2016.
//  Copyright © 2016 Brian Henry. All rights reserved.
//

import UIKit
import CoreLocation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    var locationManager: CLLocationManager?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        locationManager = CLLocationManager()
        locationManager?.requestWhenInUseAuthorization()
        
        return true
    }
}

