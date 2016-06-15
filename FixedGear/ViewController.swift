//
//  ViewController.swift
//  FixedGear
//
//  Created by Brian Henry on 13/06/2016.
//  Copyright © 2016 Brian Henry. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet var mapView: MKMapView!
    
    var data : BSData!
    
    var annotations = [MKPointAnnotation]()

    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
        mapView.showsUserLocation = true
        data = BSData()
        
        for bikeStand in data.bikeStands {
            let coordinate = bikeStand.location
            
            //let mediaURL = dictionary["mediaURL"] as! String
            let annotation = MKPointAnnotation()
            
            annotation.coordinate = coordinate
            annotation.title = bikeStand.annotationTitle
            annotation.subtitle = bikeStand.annotationSubTitle
            annotations.append(annotation)
        }
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        } else {
            mapView.showAnnotations(annotations, animated: true)
        }
        
        mapView.addAnnotations(annotations)
    }
   
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        locationManager.startUpdatingLocation()
    }

    func centerMapOnLocation(location: CLLocationCoordinate2D, regionRadius: Double) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location, regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        
        if(data.isLocationWithinBikeStandsArea(locValue)){
            centerMapOnLocation(locValue, regionRadius: 120.0)
        }else{
            mapView.showAnnotations(annotations, animated: true)
        }
        
        locationManager.stopUpdatingLocation();
    }
}

