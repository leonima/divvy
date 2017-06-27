//
//  MapViewController.swift
//  Divvy Bike App
//
//  Created by Ziyun Ma on 6/26/17.
//  Copyright © 2017 Ziyun Ma. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate
{

    var detailItems:[[String: String]]!
    
    @IBOutlet weak var myMap: MKMapView!
    
    var manager = CLLocationManager()
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        let location = locations[0]
        let span:MKCoordinateSpan = MKCoordinateSpanMake(0.1, 0.1)
        let myLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        let region:MKCoordinateRegion = MKCoordinateRegionMake(myLocation, span)
        myMap.setRegion(region, animated: true)
        
        self.myMap.showsUserLocation = true
    }
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
        for items in detailItems
        {
            var centerLocation = CLLocationCoordinate2DMake(Double(items["latitude"]!)!, Double(items["longitude"]!)!)
            
            var mapSpan = MKCoordinateSpanMake(0.08, 0.08)
            
            var mapRegion = MKCoordinateRegionMake(centerLocation, mapSpan)
            
            var annotation = MKPointAnnotation()
            annotation.coordinate = centerLocation
            
            self.myMap.setRegion(mapRegion, animated: true)
            self.myMap.addAnnotation(annotation)
            annotation.title = items["stationName"]
            annotation.subtitle = items["city"]
        }
    }
  
}
