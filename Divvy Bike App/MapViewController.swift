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

class MapViewController: UIViewController
{
    @IBOutlet weak var myMap: MKMapView!
    
    var detailItemTwo:[[String: String]]!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        for i in detailItemTwo
        {
            var centerLocation = CLLocationCoordinate2DMake(Double(detailItemTwo["latitude"]!)!, Double(detailItemTwo["longitude"]!)!)
            
            var mapSpan = MKCoordinateSpanMake(0.01, 0.01)
            
            var mapRegion = MKCoordinateRegionMake(centerLocation, mapSpan)
            
            var annotation = MKPointAnnotation()
            annotation.coordinate = centerLocation
            
            self.myMap.setRegion(mapRegion, animated: true)
            self.myMap.addAnnotation(annotation)
            annotation.title = detailItemTwo["stationName"]
            annotation.subtitle = detailItemTwo["city"]
        }
    }

}
